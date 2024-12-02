use std::fs;

pub fn hello() {
    println!("Hello from lib.rs!");
}

pub fn read_from_file(file_path: String) -> String {
    fs::read_to_string(file_path).expect("Should have been able to read the file")
}
