package listops

type binFunc func(x, y int) int
type predFunc func(n int) bool
type unaryFunc func(x int) int

type IntList []int

func (list IntList) Foldr(f binFunc, initial int) int {
	val := initial
	for idx := range list {
		val = f(list[len(list)-1-idx], val)
	}
	return val
}

func (list IntList) Foldl(f binFunc, initial int) int {
	val := initial
	for _, i := range list {
		val = f(val, i)
	}
	return val
}

func (list IntList) Filter(f predFunc) IntList {
	results := IntList{}
	for _, i := range list {
		if f(i) == true {
			results = append(results, i)
		}
	}
	return results
}

func (list IntList) Length() int {
	len := 0
	for range list {
		len++
	}
	return len
}

func (list IntList) Map(f unaryFunc) IntList {
	results := IntList{}
	for _, i := range list {
		results = append(results, f(i))
	}
	return results
}

func (list IntList) Reverse() IntList {
	results := IntList{}
	for idx := range list {
		results = append(results, list[len(list)-1-idx])
	}
	return results
}

func (list IntList) Append(l IntList) IntList {
	return append(list, l...)
}

func (list IntList) Concat(args []IntList) IntList {
	results := list
	for _, arg := range args {
		results = results.Append(arg)
	}
	return results
}
