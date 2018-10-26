package sublist

type Relation string

func Sublist(list1 []int, list2 []int) Relation {
	if isEqual(list1, list2) {
		return "equal"
	}

	if isSublist(list1, list2) {
		return "sublist"
	}

	if isSublist(list2, list1) {
		return "superlist"
	}

	return "unequal"
}

func isEqual(list1 []int, list2 []int) bool {
	if len(list1) != len(list2) {
		return false
	}

	for idx, val := range list1 {
		if list2[idx] != val {
			return false
		}
	}

	return true
}

func isSublist(list1 []int, list2 []int) bool {
	if len(list1) > len(list2) {
		return false
	}

	for i := 0; i <= len(list2)-len(list1); i++ {
		if isEqual(list1, list2[i:i+len(list1)]) {
			return true
		}
	}

	return false
}
