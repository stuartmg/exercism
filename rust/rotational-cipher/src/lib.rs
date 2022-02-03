pub fn rotate(input: &str, key: i8) -> String {
    input
        .chars()
        .map(|ch| match ch {
            'a'..='z' => rotate_char(ch, 'a', key),
            'A'..='Z' => rotate_char(ch, 'A', key),
            _ => ch,
        })
        .collect()
}

fn rotate_char(ch: char, start: char, rotations: i8) -> char {
    let (c, s) = (ch as i8, start as i8); // get ascii values
    let rotated = ((c - s) + rotations).rem_euclid(26) + s; // rotate ascii values

    (rotated as u8) as char
}
