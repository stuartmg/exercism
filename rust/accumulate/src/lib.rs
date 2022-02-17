pub fn map<F, T, U>(input: Vec<T>, mut f: F) -> Vec<U>
where F: FnMut(T) -> U {
    let mut results: Vec<U> = Vec::new();

    for val in input {
        results.push(f(val));
    }

    results
}
