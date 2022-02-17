pub fn encrypt(input: &str) -> String {
    if input.is_empty() {
        return String::from("");
    }

    crypt(square(normalize(input))).join(" ")
}

fn crypt(input: Vec<Vec<char>>) -> Vec<String> {
    let mut crypt: Vec<String> = Vec::new();

    for col in 0..input[0].len() {
        crypt.push(
            input
                .iter()
                .map(|row| if col >= row.len() { ' ' } else { row[col] })
                .collect(),
        );
    }

    return crypt;
}

fn square(input: Vec<char>) -> Vec<Vec<char>> {
    let cols: usize = (input.len() as f32).sqrt().ceil() as usize;

    input
        .chunks(cols)
        .map(|row| row.iter().map(|c| *c).collect::<Vec<char>>())
        .collect()
}

fn normalize(input: &str) -> Vec<char> {
    input
        .chars()
        .filter(|c| c.is_alphanumeric())
        .map(|c| c.to_ascii_lowercase())
        .collect()
}
