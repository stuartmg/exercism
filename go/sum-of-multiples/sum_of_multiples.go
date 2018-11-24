package summultiples

import "sort"

func SumMultiples(limit int, divisors ...int) int {
	results := []int{}

	for _, divisor := range divisors {
		for i := 1; divisor*i < limit; i++ {
			results = append(results, divisor*i)
		}
	}

	sort.Ints(results)

	sum := 0
	last := 0

	for _, val := range results {
		if val == last {
			continue
		}

		sum += val
		last = val
	}

	return sum
}
