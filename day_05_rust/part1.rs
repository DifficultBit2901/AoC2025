mod common;

fn main() {
    match common::get_input() {
        Err(e) => eprintln!("{e}"),
        Ok(input) => {
            println!("Result: {}", input.get_nums_outside_range().len());
        }
    }
}
