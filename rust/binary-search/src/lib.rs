use std::cmp::Ordering;

pub fn find<R: AsRef<[T]>, T: Ord>(search_space: R, key: T) -> Option<usize> {
    let search_space = search_space.as_ref();
    let split = search_space.len() / 2;

    match key.cmp(search_space.get(split)?) {
        Ordering::Equal => Some(split),
        Ordering::Less => find(&search_space[..split], key),
        Ordering::Greater => find(&search_space[(split + 1)..], key).map(|v| v + split + 1),
    }
}
