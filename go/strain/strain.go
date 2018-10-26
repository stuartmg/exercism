package strain

type Ints []int

func (ints Ints) Keep(fn func(int) bool) Ints {
	if ints == nil {
		return nil
	}

	results := Ints{}
	for _, val := range ints {
		if fn(val) {
			results = append(results, val)
		}
	}
	return results
}

func (ints Ints) Discard(fn func(int) bool) Ints {
	return ints.Keep(func(n int) bool { return !fn(n) })
}

type Strings []string

func (s Strings) Keep(fn func(string) bool) Strings {
	results := Strings{}
	for _, val := range s {
		if fn(val) {
			results = append(results, val)
		}
	}
	return results
}

type Lists [][]int

func (vals Lists) Keep(fn func([]int) bool) Lists {
	results := Lists{}
	for _, val := range vals {
		if fn(val) {
			results = append(results, val)
		}
	}
	return results
}
