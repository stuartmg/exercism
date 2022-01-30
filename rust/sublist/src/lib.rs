#[derive(Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(first_list: &[T], second_list: &[T]) -> Comparison {
    if first_list == second_list {
        return Comparison::Equal;
    }

    if first_list.len() < second_list.len() && is_sublist(first_list, second_list) {
        return Comparison::Sublist;
    }

    if first_list.len() > second_list.len() && is_sublist(second_list, first_list) {
        return Comparison::Superlist;
    }

    Comparison::Unequal
}

fn is_sublist<T: PartialEq>(first_list: &[T], second_list: &[T]) -> bool {
    first_list.is_empty() || second_list.windows(first_list.len()).any(|w| w == first_list)
}
