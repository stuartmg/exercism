pub fn nth(n: u32) -> u32 {
    let mut primes: Vec::<u32> = vec![];
    let mut i = 2;

    while primes.len() <= n as usize {
        if is_prime(&primes, i) {
            primes.push(i);
        }
        i += 1;
    }

    primes[n as usize]
}

fn is_prime(primes: &Vec<u32>, num: u32) -> bool {
    // for loop is faster than iter().any(...)
    for prime in primes {
        if num % prime == 0 {
            return false
        }
    }

    true
}
