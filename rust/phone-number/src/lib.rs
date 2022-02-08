use regex::Regex;

pub fn number(user_number: &str) -> Option<String> {
    let re = Regex::new(r"(?x)
        ^\+?1?\s* # optional country code +1
        \(?(?P<area>[2-9]\d{2})\)? # area code NXX
        [\.\s\-]*
        (?P<exchange>[2-9]\d{2}) # exchange NXX
        [\.\s\-]*
        (?P<subscriber>\d{4}) # subscriber number XXXX
        \s*$").unwrap();

    match re.is_match(user_number) {
        true => Some(String::from(re.replace_all(user_number, "$area$exchange$subscriber"))),
        false => None,
    }
}
