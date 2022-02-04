use std::collections::BTreeMap;
use std::collections::BTreeSet;

pub struct School {
    students: BTreeMap<u32, BTreeSet<String>>,
}

impl School {
    pub fn new() -> School {
        Self { students: BTreeMap::new() }
    }

    pub fn add(&mut self, grade: u32, student: &str) {
        let entry = self.students.entry(grade).or_insert(BTreeSet::new());
        (*entry).insert(String::from(student));
    }

    pub fn grades(&self) -> Vec<u32> {
        self.students.keys().map(|k| k.clone()).collect()
    }

    pub fn grade(&self, grade: u32) -> Vec<String> {
        match self.students.get(&grade) {
            Some(students) => students.iter().map(|k| k.clone()).collect(),
            None => vec![],
        }
    }
}
