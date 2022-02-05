#[derive(Debug, PartialEq)]
pub struct Dna {
    nucleotides: String,
}

#[derive(Debug, PartialEq)]
pub struct Rna {
    nucleotides: String,
}

const DNA: [char; 4] = ['G', 'C', 'T', 'A'];
const RNA: [char; 4] = ['G', 'C', 'A', 'U'];

impl Dna {
    pub fn new(dna: &str) -> Result<Dna, usize> {
        match dna.chars().position(|c| !DNA.contains(&c)) {
            Some(idx) => Err(idx),
            None => Ok(Self {
                nucleotides: String::from(dna),
            }),
        }
    }

    pub fn into_rna(self) -> Rna {
        let rna = self
            .nucleotides
            .chars()
            .map(|c| match c {
                'G' => 'C',
                'C' => 'G',
                'T' => 'A',
                'A' => 'U',
                _ => c,
            })
            .collect();

        Rna { nucleotides: rna }
    }
}

impl Rna {
    pub fn new(rna: &str) -> Result<Rna, usize> {
        match rna.chars().position(|c| !RNA.contains(&c)) {
            Some(idx) => Err(idx),
            None => Ok(Self {
                nucleotides: String::from(rna),
            }),
        }
    }
}
