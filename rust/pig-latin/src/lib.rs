const VOWELS: [&str; 7] = ["a", "e", "i", "o", "u", "xr", "yt"];

pub fn translate(input: &str) -> String {
    input
        .split_whitespace()
        .map(|word| translate_word(word))
        .collect::<Vec<String>>()
        .join(" ")
}

fn translate_word(word: &str) -> String {
    let idx = find_split(word);
    let (prefix, rest) = word.split_at(idx);

    format!("{}{}ay", rest, prefix)
}

fn find_split(word: &str) -> usize {
    if word.is_empty() || starts_with_vowel(word) {
        0
    } else if word.starts_with("qu") {
        2
    } else if word.chars().nth(1) == Some('y') {
        1
    } else {
        1 + find_split(&word[1..])
    }
}

fn starts_with_vowel(word: &str) -> bool {
    VOWELS.iter().any(|v| word.starts_with(v))
}

