#[derive(Clone, Copy, Debug)]
pub struct HighScores<'a> {
    scores: &'a [u32],
}

impl<'a> HighScores<'a> {
    pub fn new(scores: &'a [u32]) -> Self {
        Self { scores }
    }

    pub fn scores(&self) -> &[u32] {
        self.scores
    }

    pub fn latest(&self) -> Option<u32> {
        self.scores.iter().map(|score| *score).last()
    }

    pub fn personal_best(&self) -> Option<u32> {
        self.scores.iter().map(|score| *score).max()
    }

    pub fn personal_top_three(&self) -> Vec<u32> {
        let mut high_scores = self.scores.to_vec();
        high_scores.sort();
        high_scores.reverse();
        high_scores.truncate(3);
        high_scores
    }
}
