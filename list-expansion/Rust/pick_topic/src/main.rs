extern crate rand;

use std::error::Error;
use std::fs::File;
use std::io::prelude::*;
use std::path::Path;
use rand::Rng;

/*fn read_list(s: &str) -> Bytes {

}*/

fn main() {
    let path = Path::new("list");
    let display = path.display();
    let mut f = match File::open(&path) {
        Err(why) => panic!("couldn't open {}: {}", display,
                           Error::description(&why)),
        Ok(f) => f,
    };
    let mut buffer = String::new();
    match f.read_to_string(&mut buffer) {
        Err(why) => panic!("Error: {}", Error::description(&why)),
        Ok(_) => (),
    };
    let spl = buffer.lines();
    let my_vec = spl.collect::<Vec<_>>();
    let mut rng = rand::thread_rng();
    let my_item = match rng.choose(&my_vec) {
        None => panic!("Something went wrong"),
        Some(i) => i,
    };
    println!("item: {:?}", my_item);
}
