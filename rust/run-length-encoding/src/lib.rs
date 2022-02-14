fn encode_char(encoded: &mut String, count: u32, letter: char) {
    if count > 1 {
        encoded.push_str(&count.to_string());
    }

    encoded.push_str(&format!("{}", letter));
}

pub fn encode(source: &str) -> String {
    let mut encoded = String::new();
    let mut prev: Option<char> = None;
    let mut count: u32 = 0;

    for c in source.chars().chain(Some('\0')) {
        if prev.is_some() && prev != Some(c) {
            encode_char(&mut encoded, count, prev.unwrap());
            count = 0;
        }

        prev = Some(c);
        count += 1;
    }

    encoded
}

pub fn decode(source: &str) -> String {
    let mut count = String::new();
    let mut decoded = String::new();

    for c in source.chars() {
        if c.is_numeric() {
            count.push(c);
        } else {
            let num = count.parse().unwrap_or(1);
            let letters = c.to_string().repeat(num);

            decoded.push_str(&letters);
            count.clear();
        }
    }

    decoded
}
