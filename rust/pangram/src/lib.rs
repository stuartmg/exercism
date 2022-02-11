const ALPHABET: &str = "abcdefghijklmnopqrstuvwxyz";

/// Determine whether a sentence is a pangram.
pub fn is_pangram(sentence: &str) -> bool {
    let sentence = sentence.to_lowercase();

    ALPHABET
        .chars()
        .all(|letter| sentence.contains(letter))
}
