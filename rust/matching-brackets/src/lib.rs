pub fn brackets_are_balanced(string: &str) -> bool {
    let mut stack = vec![];

    for ch in string.chars() {
        match ch {
            '[' | '{' | '(' => stack.push(ch),
            ']' if stack.pop() != Some('[') => return false,
            '}' if stack.pop() != Some('{') => return false,
            ')' if stack.pop() != Some('(') => return false,
            _ => (),
        }
    }

    stack.is_empty()
}
