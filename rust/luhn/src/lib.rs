/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    if code.chars().any(|c| is_invalid_char(c)) {
        return false;
    }

    let digits = digits_from(code);
    if digits.len() < 2 {
        return false;
    }

    let sum: u32 = digits
        .iter()
        .rev()
        .map(|c| c.to_digit(10).unwrap_or_else(|| 0))
        .enumerate()
        .map(|(idx, num)| if idx % 2 > 0 { num * 2 } else { num })
        .map(|num| if num > 9 { num - 9 } else { num })
        .sum();

    sum % 10 == 0
}

fn is_invalid_char(c: char) -> bool {
    c.is_alphabetic() || c.is_ascii_punctuation()
}

fn digits_from(code: &str) -> Vec<char> {
    code.chars().filter(|c| c.is_numeric()).collect()
}
