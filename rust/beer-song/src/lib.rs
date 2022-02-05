pub fn verse(n: u32) -> String {
    let next_num: u32 = if n == 0 { 99 } else { n - 1};

    format!(
        "{} of beer on the wall, {} of beer.\n{}, {} of beer on the wall.\n",
        pluralize_bottles(n),
        pluralize_bottles(n).to_lowercase(),
        action(n),
        pluralize_bottles(next_num).to_lowercase(),
    )
}

pub fn sing(start: u32, end: u32) -> String {
    let mut song = vec![];

    for n in (end..=start).rev() {
        song.push(verse(n));
    }

    song.join("\n")
}

fn action(count: u32) -> String {
    match count {
        0 => String::from("Go to the store and buy some more"),
        1 => String::from("Take it down and pass it around"),
        _ => String::from("Take one down and pass it around"),
    }
}

fn pluralize_bottles(count: u32) -> String {
    match count {
        0 => String::from("No more bottles"),
        1 => String::from("1 bottle"),
        _ => format!("{} bottles", count),
    }
}
