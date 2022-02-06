use std::iter::FromIterator;

#[derive(Clone)]
struct Node<T> {
    data: T,
    next: Option<Box<Node<T>>>,
}

pub struct SimpleLinkedList<T> {
    head: Option<Box<Node<T>>>,
}

impl<T: Clone> SimpleLinkedList<T> {
    pub fn new() -> Self {
        Self { head: None }
    }

    pub fn is_empty(&self) -> bool {
        self.head.is_none()
    }

    pub fn len(&self) -> usize {
        let mut len = 0;
        let mut node = &self.head;

        while node.is_some() {
            len += 1;
            node = node.as_ref().map(|b| &b.next).unwrap();
        }

        len
    }

    pub fn push(&mut self, element: T) {
        self.head = Some(Box::new(Node { data: element, next: self.head.take() }));
    }

    pub fn pop(&mut self) -> Option<T> {
        let mut head = self.head.take();

        self.head = match head {
            Some(ref mut node) => node.next.take(),
            None => None,
        };

        head.map(|b| b.data)
    }

    pub fn peek(&self) -> Option<&T> {
        self.head.as_ref().map(|b| &b.data)
    }

    #[must_use]
    pub fn rev(self) -> SimpleLinkedList<T> {
        SimpleLinkedList::from_iter(Vec::from(self).into_iter().rev())
    }
}

impl<T: Clone> FromIterator<T> for SimpleLinkedList<T> {
    fn from_iter<I: IntoIterator<Item = T>>(iter: I) -> Self {
        let mut list = SimpleLinkedList::new();

        for data in iter {
            list.push(data.clone());
        }

        list
    }
}

impl<T: Clone> From<SimpleLinkedList<T>> for Vec<T> {
    fn from(mut linked_list: SimpleLinkedList<T>) -> Vec<T> {
        let mut data = vec![];

        while !linked_list.is_empty() {
            match linked_list.pop() {
                Some(d) => data.push(d.clone()),
                None => (),
            }
        }

        data.reverse();
        data
    }
}
