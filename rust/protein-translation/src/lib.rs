use std::collections::HashMap;

pub struct CodonsInfo<'a> {
    pairs: HashMap<&'a str, &'a str>
}

impl<'a> CodonsInfo<'a> {
    pub fn new(pairs: HashMap<&'a str, &'a str>) -> Self {
        Self { pairs }
    }

    pub fn name_for(&self, codon: &str) -> Option<&'a str> {
        self.pairs.get(codon).map(|&v| v)
    }

    pub fn of_rna(&self, rna: &str) -> Option<Vec<&'a str>> {
        match self.parse_rna(rna) {
            Ok(results) => Some(results),
            Err(_) => None,
        }
    }

    fn parse_rna(&self, rna: &str) -> Result<Vec<&'a str>, &'static str> {
        rna.chars()
            .collect::<Vec<char>>()
            .chunks(3)
            .map(|c| c.iter().collect::<String>())
            .take_while(|codon| self.name_for(&codon) != Some("stop codon"))
            .map(|codon| self.pairs.get(&codon.as_str()).cloned().ok_or(""))
            .collect()
    }
}

pub fn parse<'a>(pairs: Vec<(&'a str, &'a str)>) -> CodonsInfo<'a> {
    CodonsInfo::new(pairs.into_iter().collect())
}
