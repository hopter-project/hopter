use std::env;
use std::fs::File;
use std::io::Write;
use std::path::PathBuf;

fn main() {
    // Write the link script to the crate output directory.
    let out = &PathBuf::from(env::var_os("OUT_DIR").unwrap());
    let mut f = File::create(out.join("link.ld")).unwrap();
    f.write_all(include_bytes!("link.ld.in")).unwrap();

    // Add the output directory to linker search path.
    println!("cargo:rustc-link-search={}", out.display());
}
