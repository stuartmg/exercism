pub fn annotate(minefield: &[&str]) -> Vec<String> {
    minefield.iter()
        .enumerate()
        .map(|(row, _)| annotate_row(minefield, row))
        .collect()
}

fn annotate_row(minefield: &[&str], row: usize) -> String {
    minefield.iter().nth(row)
        .unwrap()
        .bytes()
        .enumerate()
        .map(|(col, c)| annotate_cell(minefield, row, col, c as char))
        .collect()
}

fn annotate_cell(minefield: &[&str], row: usize, col: usize, val: char) -> char {
    if val == '*' {
        return val;
    }

    match number_adjacent_mines(minefield, row, col) {
        0 => ' ',
        val => char::from_digit(val as u32, 10).unwrap()
    }
}

fn number_adjacent_mines(minefield: &[&str], row: usize, col: usize) -> usize {
    vec![
        (row.checked_sub(1), col.checked_sub(1)),   // above left
        (row.checked_sub(1), Some(col)),            // above
        (row.checked_sub(1), col.checked_add(1)),   // above right
        (Some(row), col.checked_sub(1)),            // left
        (Some(row), col.checked_add(1)),            // right
        (row.checked_add(1), col.checked_sub(1)),   // below left
        (row.checked_add(1), Some(col)),            // below
        (row.checked_add(1), col.checked_add(1)),   // below right
    ].iter()
        .filter(|(r, c)| r.is_some() && c.is_some())        // filter out invalid indexes
        .filter(|(r, _)| r.unwrap() < minefield.len())      // filter out invalid rows
        .filter(|(_, c)| c.unwrap() < minefield[0].len())   // filter out invalid cols
        .map(|(r, c)| minefield.get(r.unwrap()).unwrap().bytes().nth(c.unwrap()).unwrap())
        .filter(|c| *c as char == '*')
        .count()
}