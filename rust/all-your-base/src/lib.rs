#[derive(Debug, PartialEq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit(u32),
}

///
/// Convert a number between two bases.
///
/// A number is any slice of digits.
/// A digit is any unsigned integer (e.g. u8, u16, u32, u64, or usize).
/// Bases are specified as unsigned integers.
///
/// Return an `Err(.)` if the conversion is impossible.
/// The tests do not test for specific values inside the `Err(.)`.
///
///
/// You are allowed to change the function signature as long as all test still pass.
///
///
/// Example:
/// Input
///   number: &[4, 2]
///   from_base: 10
///   to_base: 2
/// Result
///   Ok(vec![1, 0, 1, 0, 1, 0])
///
/// The example corresponds to converting the number 42 from decimal
/// which is equivalent to 101010 in binary.
///
///
/// Notes:
///  * The empty slice ( "[]" ) is equal to the number 0.
///  * Never output leading 0 digits, unless the input number is 0, in which the output must be `[0]`.
///    However, your function must be able to process input with leading 0 digits.
///
pub fn convert(number: &[u32], from_base: u32, to_base: u32) -> Result<Vec<u32>, Error> {
    if from_base < 2 {
        return Err(Error::InvalidInputBase);
    }

    if to_base < 2 {
        return Err(Error::InvalidOutputBase);
    }

    convert_from(number, from_base).and_then(|num| convert_to(num, to_base))
}


// convert input from a base into a base 10 int
fn convert_from(number: &[u32], base: u32) -> Result<u32, Error> {
    if let Some(num) = number.iter().find(|num| **num >= base) {
        return Err(Error::InvalidDigit(*num));
    }

    let sum = number
        .iter()
        .rev()
        .enumerate()
        .map(|(idx, num)| base.pow(idx as u32) * num)
        .sum();

    Ok(sum)
}

// convert a base 10 int into an array of digits in the specific base
fn convert_to(number: u32, base: u32) -> Result<Vec<u32>, Error> {
    let mut output: Vec<u32> = Vec::new();
    let mut num = number;

    while num > 0 {
        output.insert(0, num % base);
        num /= base;
    }

    if output.is_empty() {
        output.push(0);
    }

    Ok(output)
}
