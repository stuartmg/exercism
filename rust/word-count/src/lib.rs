use std::collections::HashMap;

/// Count occurrences of words.
pub fn word_count(words: &str) -> HashMap<String, u32> {
    words
        .split(|c| is_separator(c))
        .map(|word| word.trim_matches('\''))
        .map(|word| word.to_lowercase())
        .filter(|word| !word.is_empty())
        .fold(HashMap::new(), |mut word_counts, word| {
            let entry = word_counts.entry(String::from(word)).or_insert(0);
            *entry += 1;
            word_counts
        })
}

fn is_separator(c: char) -> bool {
    c.is_whitespace() || (c.is_ascii_punctuation() && c != '\'')
}
