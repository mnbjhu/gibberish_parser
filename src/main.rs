use std::fs;

use gibberish_gibberish_parser::Gibberish;

pub fn main() {
    let file = fs::read_to_string("test.gibtest").unwrap();
    let res = Gibberish::parse(&file);
    res.debug_print(true, true, &Gibberish);
}
