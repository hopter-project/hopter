#![allow(dead_code)]
#![allow(unused_macros)]
// testing again
extern crate alloc;

#[derive(Debug)]
pub enum UartError {
    ReadError,
    WriteError,
    Other,
}

use core::{fmt::Debug, panic};

use super::{hprint, hprintln};

macro_rules! block {
    ($e:expr) => {
        loop {
            #[allow(unreachable_patterns)]
            match $e {
                Err(e) => {}
                Ok(x) => break Ok(x),
            }
        }
    };
}

pub trait UartRW {
    fn uart_read_byte(&mut self) -> Result<u8, UartError>;
    fn uart_write_byte(&mut self, byte: u8) -> Result<(), UartError>;
}

pub const MESSSAGE_SIZE: usize = 59;
pub const CHECKSUM_SIZE: usize = 4;
pub const FLAGS_SIZE: usize = 1;
pub const CHUNK_SIZE: usize = MESSSAGE_SIZE + FLAGS_SIZE + CHECKSUM_SIZE;
pub const MAX_DATA_SIZE: usize = 1024;

pub fn print_data(vec: &heapless::Vec<u8, MAX_DATA_SIZE>) {
    for i in 0..vec.len() {
        hprint!("{:02x} ", vec[i]);
        if i % 16 == 15 {
            hprintln!();
        }
    }
    hprintln!();
}
pub fn print_chunk(chunk: &Chunk) {
    hprintln!("Message: {:?}", chunk.message);
    hprintln!("Flags: {:#08b}", chunk.flags);
    hprintln!("Checksum: {}", chunk.checksum);
}

pub enum ResponseType {
    Ack,
    Nack,
}
#[derive(Clone, Copy)]
pub enum Sequence {
    Odd,
    Even,
}

pub struct Chunk {
    message: [u8; MESSSAGE_SIZE],
    flags: u8,
    checksum: u32,
}
impl Chunk {
    pub fn new(message: [u8; MESSSAGE_SIZE], flags: u8) -> Self {
        Chunk {
            message,
            flags,
            checksum: 0 as u32,
        }
    }
    pub fn compute_checksum(&mut self) {
        self.checksum = crc32fast::hash(&self.message);
    }
}

pub struct Flags {
    response_type: Option<ResponseType>,
    sequence: Option<Sequence>,
}

impl Flags {
    pub fn new(response_type: Option<ResponseType>, sequence: Option<Sequence>) -> Self {
        Flags {
            response_type,
            sequence,
            
        }
    }
    pub fn from_byte(byte: u8) -> Self {
        Flags {
            response_type: match byte & 0xF0 {
                0xA0 => Some(ResponseType::Ack),
                0x50 => Some(ResponseType::Nack),
                _ => None,
            },
            sequence: match byte & 0x0F {
                0x0A => Some(Sequence::Odd),
                0x05 => Some(Sequence::Even),
                _ => None,
            },
        }
    }
    pub fn to_byte(&self) -> u8 {
        let mut buf: u8 = 0;
        buf |= match self.response_type {
            Some(ResponseType::Ack) => 0xA0,
            Some(ResponseType::Nack) => 0x50,
            None => 0x00,
        };

        buf |= match self.sequence {
            Some(Sequence::Odd) => 0x0A,
            Some(Sequence::Even) => 0x05,
            None => 0x00,
        };
        buf
    }
    pub fn toggle(&mut self) {
        self.sequence = match self.sequence {
            Some(Sequence::Odd) => Some(Sequence::Even),
            Some(Sequence::Even) => Some(Sequence::Odd),
            None => None,
        }
    }
}

pub struct UartCrc<'a, T: UartRW> {
    serial: &'a mut T,
}

impl<'a, T: UartRW> UartCrc<'a, T> {
    pub fn new(serial: &'a mut T) -> Self {
        UartCrc { serial }
    }

    pub fn send_ack(&mut self) -> Result<(), UartError> {
        self.send_response(Flags::new(Some(ResponseType::Ack), None))?;
        Ok(())
    }
    pub fn send_nack(&mut self) -> Result<(), UartError> {
        self.send_response(Flags::new(Some(ResponseType::Nack), None))?;
        Ok(())
    }
    pub fn send_response(&mut self, flags: Flags) -> Result<(), UartError> {
        let buf = flags.to_byte();
        hprintln!("Sending response {:#08b}", buf);
        self.serial.uart_write_byte(buf)?;
        Ok(())
    }

    pub fn listen_for_response(&mut self) -> Result<Flags, UartError> {
        let buf = self.serial.uart_read_byte()?;
        let flags = Flags {
            response_type: match buf & 0xF0 {
                0xA0 => Some(ResponseType::Ack),
                0x50 => Some(ResponseType::Nack),
                _ => None,
            },
            sequence: match buf & 0x0F {
                0x0A => Some(Sequence::Odd),
                0x05 => Some(Sequence::Even),
                _ => None,
            },
        };
        // TODO: actual error handling
        match flags.response_type {
            Some(ResponseType::Ack) => hprintln!("Received Ack"),
            _ => panic!("Response not Ack"),
        }

        Ok(flags)
    }

    pub fn send_chunk(&mut self, chunk: &Chunk) -> Result<(), UartError> {
        let mut buf: [u8; CHUNK_SIZE] = [0; CHUNK_SIZE];
        buf[0..MESSSAGE_SIZE].copy_from_slice(&chunk.message);

        buf[MESSSAGE_SIZE] = chunk.flags;

        buf[(MESSSAGE_SIZE + FLAGS_SIZE)..CHUNK_SIZE]
            .copy_from_slice(&chunk.checksum.to_le_bytes());

        for i in 0..CHUNK_SIZE {
            self.serial.uart_write_byte(buf[i])?;
        }
        Ok(())
    }

    pub fn listen_for_chunk(&mut self) -> Result<Chunk, UartError> {
        let mut buf: [u8; CHUNK_SIZE] = [0; CHUNK_SIZE];
        for i in 0..CHUNK_SIZE {
            buf[i] = self.serial.uart_read_byte()?;
        }
        let message = buf[0..MESSSAGE_SIZE].try_into().unwrap();
        let flags = buf[MESSSAGE_SIZE];

        let mut message_checksum_b: [u8; CHECKSUM_SIZE] = [0; CHECKSUM_SIZE];
        message_checksum_b.copy_from_slice(&buf[(MESSSAGE_SIZE + FLAGS_SIZE)..CHUNK_SIZE]);
        let message_checksum = u32::from_le_bytes(message_checksum_b);

        let checksum = crc32fast::hash(&buf[0..MESSSAGE_SIZE]);
        if checksum != message_checksum {
            panic!("Checksum mismatch");
        }

        let chunk = Chunk {
            message,
            flags,
            checksum,
        };
        // print_chunk(&chunk);
        Ok(chunk)
    }

    pub fn listen_for_data_size(&mut self) -> Result<u64, UartError> {
        let chunk = self.listen_for_chunk()?;
        let data_size = u64::from_le_bytes(chunk.message[0..8].try_into().unwrap());
        hprintln!("Data_size: {}", data_size);
        Ok(data_size)
    }
    pub fn listen_for_data(&mut self) -> Result<heapless::Vec<u8, MAX_DATA_SIZE>, UartError> {
        let data_size = self.listen_for_data_size()?;
        self.send_ack()?;
        let mut data: heapless::Vec<u8, MAX_DATA_SIZE> = heapless::Vec::new();

        let mut current_read_size = 0;
        let mut last_sequence = 0x0A;
        while current_read_size < data_size {
            let chunk = self.listen_for_chunk()?;
            if chunk.flags & 0x0F == last_sequence {
                self.send_nack()?;
                panic!("Sequence mismatch");
            } else {
                last_sequence = chunk.flags & 0x0F;
                self.send_ack()?;
            }

            if data_size - current_read_size > MESSSAGE_SIZE as u64 {
                let _ = data.extend_from_slice(&chunk.message);
            } else {
                let _ = data
                    .extend_from_slice(&chunk.message[0..(data_size - current_read_size) as usize]);
            }
            current_read_size += MESSSAGE_SIZE as u64;
        }
        Ok(data)
    }
    pub fn send_data_size(&mut self, datasize: usize) -> Result<(), UartError> {
        let mut message = [0; MESSSAGE_SIZE];
        message[0..8].copy_from_slice(&(datasize as u64).to_le_bytes());
        let flags = Flags::new(None, Some(Sequence::Odd));
        let checksum = crc32fast::hash(&message);
        let chunk = Chunk {
            message: message,
            flags: flags.to_byte(),
            checksum: checksum,
        };
        self.send_chunk(&chunk)?;
        Ok(())
    }
    pub fn send_data(&mut self, data: heapless::Vec<u8, MAX_DATA_SIZE>) -> Result<(), UartError> {
        let data_size = data.len() as usize;
        self.send_data_size(data_size)?;
        self.listen_for_response()?;

        let mut flags = Flags::new(None, Some(Sequence::Even));
        let mut current_write_size: usize = 0;

        while current_write_size < data_size {
            let mut message: [u8; MESSSAGE_SIZE] = [0; MESSSAGE_SIZE];
            if (current_write_size + MESSSAGE_SIZE) < data_size {
                message.copy_from_slice(
                    &data[current_write_size..(current_write_size + MESSSAGE_SIZE)],
                );
                current_write_size += MESSSAGE_SIZE;
            } else {
                let diff = data_size - current_write_size;
                message[0..diff]
                    .copy_from_slice(&data[current_write_size..(current_write_size + diff)]);
                current_write_size += diff;
            }

            let mut chunk = Chunk::new(message, flags.to_byte());
            chunk.compute_checksum();

            self.send_chunk(&chunk)?;

            // TODO: Implement retransmission
            self.listen_for_response()?;

            flags.toggle();
        }
        Ok(())
    }
}
