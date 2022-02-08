use rand::{thread_rng, Rng};

const LOWERCASE: &[u8; 26] = b"abcdefghijklmnopqrstuvwxyz";

pub fn encode(key: &str, s: &str) -> Option<String> {
    if is_valid_key(key) {
        Some(s.chars().enumerate().map(|(idx, c)| encode_letter(c, key, idx)).collect::<String>())
    } else {
        None
    }
}

pub fn decode(key: &str, s: &str) -> Option<String> {
    if is_valid_key(key) {
        Some(s.chars().enumerate().map(|(idx, c)| decode_letter(c, key, idx)).collect::<String>())
    } else {
        None
    }
}

pub fn encode_random(s: &str) -> (String, String) {
    let key = generate_key(100);
    let encoded = encode(&key, s).unwrap();

    (key, encoded)
}

fn generate_key(length: u8) -> String {
    let mut key = String::new();

    for _ in 0..length {
        key.push(thread_rng().choose(LOWERCASE).cloned().unwrap().into());
    }

    key
}

fn is_valid_key(key: &str) -> bool {
    let normalized = key.chars().filter(|c| c.is_ascii_lowercase()).collect::<String>();

    normalized.len() == key.len() && !normalized.is_empty()
}

fn encode_letter(letter: char, key: &str, offset: usize) -> char {
    let off = (letter_value(letter) + letter_offset(key, offset)).rem_euclid(26);
    ('a' as u8 + off as u8) as char
}

fn decode_letter(letter: char, key: &str, offset: usize) -> char {
    let off = (letter_value(letter) - letter_offset(key, offset)).rem_euclid(26);
    ('a' as u8 + off as u8) as char
}

fn letter_value(letter: char) -> i32 {
    letter as i32 - 'a' as i32
}

fn letter_offset(key: &str, offset: usize) -> i32 {
    (key.chars().nth(offset % key.len()).unwrap() as i32 - 'a' as i32) % 26
}
