package change

import "errors"

func Change(coins []int, target int) ([]int, error) {
	var results []int

	for i := len(coins); i > 0; i-- {
		change, err := makeChange(coins[:i], target)
		if err != nil {
			continue
		}

		if results == nil || len(change) < len(results) {
			results = change
		}
	}

	if results == nil {
		return nil, errors.New("Exact change can't be given")
	}

	return results, nil
}

func makeChange(coins []int, target int) ([]int, error) {
	change := make([]int, 0, len(coins))

	for i := len(coins) - 1; i >= 0; i-- {
		for target >= coins[i] {
			if target-coins[i] != 0 && target-coins[i] < coins[0] {
				break
			}

			change = append([]int{coins[i]}, change...)
			target -= coins[i]

			if i > 0 && target%coins[i] != 0 && target%coins[i-1] == 0 {
				break
			}
		}
	}

	if target != 0 {
		return nil, errors.New("Exact change can't be given")
	}

	return change, nil
}
