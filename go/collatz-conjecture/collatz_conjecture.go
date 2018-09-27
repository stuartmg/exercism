package collatzconjecture

import "errors"

// CollatzConjecture find number of steps to reach 1 using collatz conjecture
func CollatzConjecture(start int) (int, error) {
	if start < 1 {
		return -1, errors.New("start must be greater than zero")
	}

	return perform(start, 0), nil
}

func perform(n, steps int) int {
	switch {
	case n == 1:
		return steps
	case n%2 == 0:
		return perform(n/2, steps+1)
	default:
		return perform(n*3+1, steps+1)
	}
}
