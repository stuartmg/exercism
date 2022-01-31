use std::fmt::{Display, Formatter, Result};

const NUMERALS: [(u32, &str); 13] = [
    (1000, "M"),
    (900, "CM"),
    (500, "D"),
    (400, "CD"),
    (100, "C"),
    (90, "XC"),
    (50, "L"),
    (40, "XL"),
    (10, "X"),
    (9, "IX"),
    (5, "V"),
    (4, "IV"),
    (1, "I"),
];

pub struct Roman {
    num: u32,
}

impl Display for Roman {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
        let mut total = self.num;
        let mut output = String::new();

        for (val, str) in NUMERALS.iter() {
            while total >= *val {
                total -= val;
                output.push_str(str);
            }
        }

        write!(f, "{}", output)
    }
}

impl From<u32> for Roman {
    fn from(num: u32) -> Self {
        Self { num }
    }
}
