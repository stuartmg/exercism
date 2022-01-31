pub fn reply(message: &str) -> &str {
    let msg = message.trim();
    let yelling = msg == msg.to_uppercase() && msg.chars().any(|c| c.is_alphabetic());

    match msg.chars().last() {
        None => "Fine. Be that way!",
        Some('?') if yelling => "Calm down, I know what I'm doing!",
        Some('?') => "Sure.",
        Some(_) if yelling => "Whoa, chill out!",
        Some(_) => "Whatever.",
    }
}
