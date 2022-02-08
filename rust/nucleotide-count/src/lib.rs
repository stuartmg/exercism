use std::collections::HashMap;

const NUCLEOTIDES: [char; 4] = ['A', 'C', 'G', 'T'];

pub fn count(nucleotide: char, dna: &str) -> Result<usize, char> {
    if !NUCLEOTIDES.contains(&nucleotide) {
        return Err(nucleotide);
    }

    match nucleotide_counts(dna) {
        Ok(counts) => Ok(*counts.get(&nucleotide).unwrap()),
        Err(err) => Err(err),
    }
}

pub fn nucleotide_counts(dna: &str) -> Result<HashMap<char, usize>, char> {
    let mut map = HashMap::from(NUCLEOTIDES.map(|c| (c, 0)));

    for c in dna.chars() {
        map.get_mut(&c).map(|count| *count += 1).ok_or(c)?
    }

    Ok(map)
}
