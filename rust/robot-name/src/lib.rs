use std::collections::HashSet;
use std::sync::Mutex;
use rand::Rng;

#[macro_use]
extern crate lazy_static;

lazy_static! {
    static ref USED_NAMES: Mutex<HashSet<String>> = Mutex::new(HashSet::new());
}

pub struct Robot {
    name: String,
}

impl Robot {
    pub fn new() -> Self {
        Self { name: Robot::random_name() }
    }

    pub fn name(&self) -> &str {
        self.name.as_str()
    }

    pub fn reset_name(&mut self) {
        USED_NAMES.lock().unwrap().remove(&self.name);
        self.name = Robot::random_name()
    }

    fn random_name() -> String {
        let mut rng = rand::thread_rng();
        let mut used = USED_NAMES.lock().unwrap();

        loop {
            let mut name = String::new();

            for _ in 0..2 {
                name += &rng.gen_range('A'..='Z').to_string();
            }

            let n: u32 = rng.gen_range(0..1000);
            name.push_str( &format!("{:03}", n) );

            if used.insert(name.clone()) {
                return name
            }
        }
    }
}
