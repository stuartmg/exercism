package armstrong

import (
	"math"
	"strconv"
)

func IsNumber(num int) bool {
	input := strconv.Itoa(num)
	power := float64(len(input))
	sum := float64(0)

	for _, i := range digits(input) {
		sum += math.Pow(float64(i), power)
	}

	return int(sum) == num
}

func digits(input string) []int {
	vals := make([]int, 0, len(input))

	for _, ch := range input {
		val, err := strconv.Atoi(string(ch))
		if err != nil {
			continue
		}

		vals = append(vals, val)
	}

	return vals
}
