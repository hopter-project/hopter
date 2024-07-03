#![no_std]
#![no_main]

extern crate alloc;




use hopter::{boot::main, debug::semihosting, hprint, hprintln};
use nb::block;
use stm32f4xx_hal::{
    gpio::GpioExt, pac::USART1, prelude::*, rcc::RccExt, serial::Serial,
    uart::Config,
};

trait UartRW {
    fn uart_read(&mut self) -> u8;
    fn uart_write(&mut self, byte: u8);
}
impl UartRW for Serial<USART1> {
    fn uart_read(&mut self) -> u8 {
        block!(self.read()).unwrap()
    }
    fn uart_write(&mut self, byte: u8) {
        block!(self.write(byte)).unwrap()
    }
}

const MESSAGE_SIZE: usize = 59;
const CHECKSUM_SIZE: usize = 4;
const FLAGS_SIZE: usize = 1;
const CHUNK_SIZE: usize = MESSAGE_SIZE + FLAGS_SIZE + CHECKSUM_SIZE;
const MAX_DATA_SIZE: usize = 1024;

fn print_data(vec: &heapless::Vec<u8, MAX_DATA_SIZE>) {
    for i in 0..vec.len() {
        hprint!("{:02x} ", vec[i]);
        if i % 16 == 15 {
            hprintln!();
        }
    }
    hprintln!();
}
fn print_chunk(chunk: &Chunk) {
    hprintln!("Message: {:?}", chunk.message);
    hprintln!("Flags: {:#08b}", chunk.flags);
    hprintln!("Checksum: {}", chunk.checksum);
}

pub enum ResponseType {
    Ack,
    Nack,
}

pub enum Sequence {
    Odd,
    Even,
}

struct Chunk {
    message: [u8; MESSAGE_SIZE],
    flags: u8,
    checksum: u32,
}
impl Chunk {
    pub fn new(message: [u8; MESSAGE_SIZE], flags: u8) -> Self {
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

struct Flags {
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

struct UartCrc<'a, T: UartRW> {
    serial: &'a mut T,
}

impl<'a, T: UartRW> UartCrc<'a, T> {
    pub fn new(serial: &'a mut T) -> Self {
        UartCrc { serial }
    }

    pub fn send_ack(&mut self) {
        self.send_response(Flags::new(Some(ResponseType::Ack), None));
    }
    pub fn send_nack(&mut self) {
        self.send_response(Flags::new(Some(ResponseType::Nack), None));
    }
    pub fn send_response(&mut self, flags: Flags) {
        let buf = flags.to_byte();
        hprintln!("Sending response {:#08b}", buf);
        self.serial.uart_write(buf);
    }

    pub fn listen_for_response(&mut self) -> Flags {
        let buf = self.serial.uart_read();
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
        hprintln!("Received response {:#08b}", flags.to_byte());
        flags
    }

    pub fn send_chunk(&mut self, chunk: &Chunk) {
        let mut buf: [u8; CHUNK_SIZE] = [0; CHUNK_SIZE];
        buf[0..MESSAGE_SIZE].copy_from_slice(&chunk.message);

        buf[MESSAGE_SIZE] = chunk.flags;

        buf[(MESSAGE_SIZE + FLAGS_SIZE)..CHUNK_SIZE]
            .copy_from_slice(&chunk.checksum.to_le_bytes());
        for i in 0..CHUNK_SIZE {
            self.serial.uart_write(buf[i]);
        }
    }

    pub fn listen_for_chunk(&mut self) -> Chunk {
        let mut buf: [u8; CHUNK_SIZE] = [0; CHUNK_SIZE];
        for i in 0..CHUNK_SIZE {
            buf[i] = self.serial.uart_read();
        }
        let message = buf[0..MESSAGE_SIZE].try_into().unwrap();
        let flags = buf[MESSAGE_SIZE];

        let mut message_checksum_b: [u8; CHECKSUM_SIZE] = [0; CHECKSUM_SIZE];
        message_checksum_b.copy_from_slice(&buf[(MESSAGE_SIZE + FLAGS_SIZE)..CHUNK_SIZE]);
        let message_checksum = u32::from_le_bytes(message_checksum_b);

        let checksum = crc32fast::hash(&buf[0..MESSAGE_SIZE]);
        if checksum != message_checksum {
            panic!("Checksum mismatch");
        }

        let chunk = Chunk {
            message,
            flags,
            checksum,
        };
        // print_chunk(&chunk);
        chunk
    }

    pub fn listen_for_data_size(&mut self) -> u64 {
        let chunk = self.listen_for_chunk();
        let data_size = u64::from_le_bytes(chunk.message[0..8].try_into().unwrap());
        hprintln!("Data_size: {}", data_size);
        data_size
    }
    pub fn listen_for_data(&mut self) -> heapless::Vec<u8, MAX_DATA_SIZE> {
        let data_size = self.listen_for_data_size();
        self.send_ack();
        let mut data: heapless::Vec<u8, MAX_DATA_SIZE> = heapless::Vec::new();

        let mut current_read_size = 0;
        while current_read_size < data_size {
            let chunk = self.listen_for_chunk();
            self.send_ack();

            if data_size - current_read_size > MESSAGE_SIZE as u64 {
                data.extend_from_slice(&chunk.message);
            } else {
                data.extend_from_slice(&chunk.message[0..(data_size - current_read_size) as usize]);
            }
            current_read_size += MESSAGE_SIZE as u64;
        }
        data
    }
    pub fn send_data_size(&mut self, datasize: usize) {
        let mut message = [0; MESSAGE_SIZE];
        message[0..8].copy_from_slice(&(datasize as u64).to_le_bytes());
        let flags = Flags::new(None, Some(Sequence::Odd));
        let checksum = crc32fast::hash(&message);
        let chunk = Chunk {
            message: message,
            flags: flags.to_byte(),
            checksum: checksum,
        };
        self.send_chunk(&chunk);
    }
    pub fn send_data(&mut self, data: heapless::Vec<u8, MAX_DATA_SIZE>) {
        let data_size = data.len() as usize;
        self.send_data_size(data_size);
        self.listen_for_response();

        let mut flags = Flags::new(None, Some(Sequence::Even));
        let mut current_write_size: usize = 0;

        while current_write_size < data_size {
            let mut message: [u8; MESSAGE_SIZE] = [0; MESSAGE_SIZE];
            if (current_write_size + MESSAGE_SIZE) < data_size {
                message.copy_from_slice(
                    &data[current_write_size..(current_write_size + MESSAGE_SIZE)],
                );
                current_write_size += MESSAGE_SIZE;
            } else {
                let diff = data_size - current_write_size;
                message[0..diff]
                    .copy_from_slice(&data[current_write_size..(current_write_size + diff)]);
                current_write_size += diff;
            }

            let mut chunk = Chunk::new(message, flags.to_byte());
            chunk.compute_checksum();

            self.send_chunk(&chunk);

            // TODO: Implement retransmission
            let response = self.listen_for_response().response_type;
            match response {
                Some(ResponseType::Ack) => {}
                Some(ResponseType::Nack) => {
                    self.send_chunk(&chunk);
                }
                None => {
                    panic!("Response needs to include ack or nack")
                }
            }

            flags.toggle();
        }
    }
}

#[main]
fn main(_: cortex_m::Peripherals) {
    hprintln!("Starting uart test...");

    let dp = unsafe { stm32f4xx_hal::pac::Peripherals::steal() };

    let clocks = dp.RCC.constrain().cfgr.freeze();

    let gpioa = dp.GPIOA.split();
    let usart1_pins = (
        gpioa.pa9.into_alternate::<7>(),
        gpioa.pa10.into_alternate::<7>(),
    );

    let mut usart1: Serial<_, u8> = dp
        .USART1
        .serial(
            usart1_pins,
            Config::default().baudrate(115200.bps()),
            &clocks,
        )
        .unwrap();

    let mut uart_crc = UartCrc::new(&mut usart1);

    let mut request: heapless::Vec<u8, MAX_DATA_SIZE> = heapless::Vec::new();

    for i in 0..500 {
        request.push(i as u8).unwrap();
    }

    let mut chunk = Chunk::new([0; MESSAGE_SIZE], 0);
    chunk.compute_checksum();
    // uart_crc.send_data_size(request.len() as usize);

    // uart_crc.send_data(request);
    uart_crc.send_data(request);

    let binary: heapless::Vec<u8, MAX_DATA_SIZE> = uart_crc.listen_for_data();
    print_data(&binary);
    // uart_crc.listen_for_response

    semihosting::terminate(true);
}
