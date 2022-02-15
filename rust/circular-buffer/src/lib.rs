use std::fmt::Debug;

pub struct CircularBuffer<T> {
    data: Vec<Option<T>>,
    capacity: usize,
    read_index: usize,
    write_index: usize,
}

#[derive(Debug, PartialEq)]
pub enum Error {
    EmptyBuffer,
    FullBuffer,
}

impl<T: Clone + Debug> CircularBuffer<T> {
    pub fn new(capacity: usize) -> Self {
        Self { data: Self::default_data(capacity), capacity: capacity, read_index: 0, write_index: 0 }
    }

    pub fn write(&mut self, element: T) -> Result<(), Error> {
        if self.data[self.write_index].is_some() {
            return Err(Error::FullBuffer);
        }

        let _ = std::mem::replace(&mut self.data[self.write_index], Some(element));
        self.advance_write_index();

        Ok(())
    }

    pub fn read(&mut self) -> Result<T, Error> {
        match std::mem::replace(&mut self.data[self.read_index], None) {
            None => Err(Error::EmptyBuffer),
            Some(val) => {
                self.advance_read_index();
                Ok(val)
            }
        }
    }

    pub fn clear(&mut self) {
        self.data = Self::default_data(self.capacity)
    }

    pub fn overwrite(&mut self, element: T) {
        let _ = std::mem::replace(&mut self.data[self.write_index], Some(element));

        self.advance_write_index();
        self.read_index = self.write_index;
    }

    fn advance_read_index(&mut self) {
        self.read_index = (self.read_index + 1) % self.capacity;
    }

    fn advance_write_index(&mut self) {
        self.write_index = (self.write_index + 1) % self.capacity;
    }

    fn default_data(capcity: usize) -> Vec<Option<T>> {
        (0..capcity).map(|_| None).collect()
    }
}
