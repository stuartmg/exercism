use std::collections::HashSet;

pub fn find(sum: u32) -> HashSet<[u32; 3]> {
    let mut result = HashSet::new();

    let mut a = 1;
    let mut b = 2;
    let mut c = sum - a - b;

    while b < c {
        if a.pow(2) + b.pow(2) == c.pow(2) {
            result.insert([a, b, c]);
        }

        if b + 1 < c - 1 {
            b += 1;
        } else {
            a += 1;
            b = a + 1;
        }

        c = sum - a - b;
    }

    return result;
}
