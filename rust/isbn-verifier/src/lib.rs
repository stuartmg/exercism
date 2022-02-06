/// Determines whether the supplied string is a valid ISBN number
pub fn is_valid_isbn(isbn: &str) -> bool {
    let filtered = isbn.chars().filter(|&c| c.is_numeric() || c == 'X').collect::<String>();

    // check if isbn is too short or long
    if filtered.len() != 10 {
        return false;
    }

    // first 9 chars must be digits
    match filtered.chars().position(|c| !c.is_numeric()) {
        Some(idx) if idx < 9 => return false,
        _ => ()
    }

    let sum = filtered
        .chars()
        .map(|c| c.to_digit(10).unwrap_or(10))
        .rev()
        .enumerate()
        .map(|(idx, n)| (idx as u32 + 1) * n)
        .sum::<u32>();

    sum % 11 == 0
}
