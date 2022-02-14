use std::cmp::Ord;
use std::fmt::Debug;

#[derive(Debug, PartialEq)]
pub struct CustomSet<T> {
    items: Vec::<T>,
}

impl<T: Clone + Debug + Eq + Ord> CustomSet<T> {
    pub fn new(input: &[T]) -> Self {
        let mut items = Vec::from(input);
        items.sort_unstable();
        items.dedup();

        Self { items }
    }

    pub fn contains(&self, element: &T) -> bool {
        self.items.contains(element)
    }

    pub fn add(&mut self, element: T) {
        self.items.push(element);
        self.items.sort_unstable();
        self.items.dedup();
    }

    pub fn is_subset(&self, other: &Self) -> bool {
        match (self.is_empty(), other.is_empty()) {
            (true, true) => true,
            (true, false) => true,
            (false, true) => false,
            (false, false) => self.items.iter().all(|o| other.contains(&o))
        }
    }

    pub fn is_empty(&self) -> bool {
        self.items.is_empty()
    }

    pub fn is_disjoint(&self, other: &Self) -> bool {
        self.intersection(other).is_empty()
    }

    #[must_use]
    pub fn intersection(&self, other: &Self) -> Self {
        Self::new( &self.items.iter().filter(|i| other.contains(i)).cloned().collect::<Vec<T>>() )
    }

    #[must_use]
    pub fn difference(&self, other: &Self) -> Self {
        Self::new( &self.items.iter().filter(|i| !other.contains(i)).cloned().collect::<Vec<T>>() )
    }

    #[must_use]
    pub fn union(&self, other: &Self) -> Self {
        Self::new( &self.items.iter().chain(other.items.iter()).cloned().collect::<Vec<T>>() )
    }
}
