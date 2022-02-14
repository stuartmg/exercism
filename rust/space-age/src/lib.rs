const EARTH_SECONDS_PER_YEAR: f64 = 31_557_600.0;

#[derive(Debug)]
pub struct Duration {
    s: u64,
}

impl From<u64> for Duration {
    fn from(s: u64) -> Self {
        Self { s }
    }
}

impl Duration {
    pub fn earth_years(&self) -> f64 {
        self.s as f64 / EARTH_SECONDS_PER_YEAR
    }
}

pub trait Planet {
    fn years_during(d: &Duration) -> f64;
}

macro_rules! planet {
    ($name:ident, $multiplier:expr) => {
        pub struct $name;
        impl Planet for $name {
            fn years_during(d: &Duration) -> f64 {
                d.earth_years() / $multiplier
            }
        }
    }
}

planet![Mercury, 0.2408467];
planet![Venus, 0.61519726];
planet![Earth, 1.0];
planet![Mars, 1.8808158];
planet![Jupiter, 11.862615];
planet![Saturn, 29.447498];
planet![Uranus, 84.016846];
planet![Neptune, 164.79132];
