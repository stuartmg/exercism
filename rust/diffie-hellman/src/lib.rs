use rand::{thread_rng, Rng};

pub fn private_key(p: u64) -> u64 {
    thread_rng().gen_range(2..p)
}

pub fn public_key(p: u64, g: u64, a: u64) -> u64 {
    modular_pow(g, a, p)
}

pub fn secret(p: u64, b_pub: u64, a: u64) -> u64 {
    modular_pow(b_pub, a, p)
}

fn modular_pow(base: u64, exponent: u64, modulus: u64) -> u64 {
    let mut b = base;
    let mut e = exponent;
    let mut result = 1;

    if (1 as u64 & e) == 1 {
        result = b;
    }

    loop {
        if e == 0 {
            break;
        }

        e = e >> 1;
        b = b.pow(2) % modulus;

        if (e & 1) == 1 {
            result = (result * b) % modulus;
        }
    }

    result
}
