use std::collections::HashSet;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let sorted = sorted_letters(word);
    let lower_cased = word.to_lowercase();

    let mut anagrams: HashSet<&'a str> = HashSet::new();

    for candidate in possible_anagrams {
        if lower_cased != candidate.to_lowercase() && sorted == sorted_letters(candidate) {
            anagrams.insert(candidate);
        }
    }

    anagrams
}

fn sorted_letters(word: &str) -> String {
    let mut chars: Vec<char> = word.to_lowercase().chars().collect();
    chars.sort_unstable();

    chars.iter().collect()
}
