package wordy

import (
	"strconv"
	"strings"
)

func Answer(question string) (int, bool) {
	q := strings.TrimPrefix(strings.TrimSuffix(question, "?"), "What is ")

	plus := func(a, b int) int { return a + b }
	minus := func(a, b int) int { return a - b }
	times := func(a, b int) int { return a * b }
	divide := func(a, b int) int { return a / b }

	tokens := strings.Split(q, " ")
	sum := 0

	val, err := strconv.Atoi(tokens[0])
	if err != nil {
		return -1, false
	}

	sum = val

	for i := 1; i < len(tokens); {
		fn := plus
		switch tokens[i] {
		case "plus":
			fn = plus
			i++
		case "minus":
			fn = minus
			i++
		case "multiplied":
			fn = times
			i += 2
		case "divided":
			fn = divide
			i += 2
		}

		val, err := strconv.Atoi(tokens[i])
		if err != nil {
			return -1, false
		}

		sum = fn(sum, val)
		i++
	}

	return sum, true
}
