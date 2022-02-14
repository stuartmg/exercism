#[derive(Debug)]
pub struct ChessPosition {
    pub rank: i32,
    pub file: i32,
}

#[derive(Debug)]
pub struct Queen {
    position: ChessPosition,
}

impl ChessPosition {
    pub fn new(rank: i32, file: i32) -> Option<Self> {
        if rank < 0 || rank > 7 || file < 0 || file > 7 {
            return None;
        }

        Some(Self { rank, file })
    }
}

impl Queen {
    pub fn new(position: ChessPosition) -> Self {
        Self { position }
    }

    pub fn can_attack(&self, other: &Queen) -> bool {
        self.same_rank(other) || self.same_file(other) || self.same_diagonal(other)
    }

    fn same_rank(&self, other: &Queen) -> bool {
        self.position.rank == other.position.rank
    }

    fn same_file(&self, other: &Queen) -> bool {
        self.position.file == other.position.file
    }

    fn same_diagonal(&self, other: &Queen) -> bool {
        (other.position.rank - self.position.rank).abs() == (other.position.file - self.position.file).abs()
    }
}
