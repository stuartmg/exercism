pub fn collatz(n: u64) -> Option<u64> {
    match n {
        0 => None,
        _ => solve(n, 0)
    }
}

fn solve(n: u64, count: u64) -> Option<u64> {
    if n == 1 {
        return Some(count);
    }

    match n % 2 {
        0 => solve(n/2, count+1),
        _ => solve(n.checked_mul(3)?.checked_add(1)?, count+1),
    }
}
