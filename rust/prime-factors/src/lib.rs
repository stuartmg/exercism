pub fn factors(n: u64) -> Vec<u64> {
    let mut results: Vec::<u64> = Vec::new();
    let mut remaining = n;
    let mut factor = 2;

    while remaining > 1 {
        if remaining % factor == 0 {
            results.push(factor);
            remaining /= factor;
        } else {
            factor += 1;
        }
    }

    results
}
