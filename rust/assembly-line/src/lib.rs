// This stub file contains items which aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

const CARS_PER_HOUR: f64 = 221.0;

fn success_rate_per_hour(speed: u8) -> f64 {
    match speed {
        0 => 0.0,
        1..=4 => 1.0,
        5..=8 => 0.9,
        9..=10 => 0.77,
        _ => panic!("too fast!"),
    }
}

pub fn production_rate_per_hour(speed: u8) -> f64 {
    let total_cars = CARS_PER_HOUR * (speed as f64);

    total_cars * success_rate_per_hour(speed)
}

pub fn working_items_per_minute(speed: u8) -> u32 {
    let rate_per_hour = production_rate_per_hour(speed) as u32;

    rate_per_hour / 60
}
