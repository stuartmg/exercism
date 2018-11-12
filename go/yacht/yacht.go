package yacht

import (
	"sort"
)

// given the dice and a category, it returns a score
func Score(dice []int, category string) int {
	switch category {
	case "ones":
		if count, ok := groupDice(dice)[1]; ok {
			return count * 1
		}
	case "twos":
		if count, ok := groupDice(dice)[2]; ok {
			return count * 2
		}
	case "threes":
		if count, ok := groupDice(dice)[3]; ok {
			return count * 3
		}
	case "fours":
		if count, ok := groupDice(dice)[4]; ok {
			return count * 4
		}
	case "fives":
		if count, ok := groupDice(dice)[5]; ok {
			return count * 5
		}
	case "sixes":
		if count, ok := groupDice(dice)[6]; ok {
			return count * 6
		}
	case "full house":
		return scoreFullHouse(groupDice(dice))
	case "four of a kind":
		for num, count := range groupDice(dice) {
			if count >= 4 {
				return num * 4
			}
		}
	case "little straight":
		if sortAndCompare(dice, []int{1, 2, 3, 4, 5}) {
			return 30
		}
	case "big straight":
		if sortAndCompare(dice, []int{2, 3, 4, 5, 6}) {
			return 30
		}
	case "choice":
		sum := 0
		for _, die := range dice {
			sum += die
		}
		return sum
	case "yacht":
		if len(groupDice(dice)) == 1 {
			return 50
		}
	}

	return 0
}

func sortAndCompare(dice []int, target []int) bool {
	sort.Ints(dice)

	for i := 0; i < len(dice); i++ {
		if dice[i] != target[i] {
			return false
		}
	}

	return true
}

func scoreFullHouse(groups map[int]int) int {
	sum := 0
	hasTwo, hasThree := false, false

	for num, count := range groups {
		sum += num * count

		if count == 2 {
			hasTwo = true
		}
		if count == 3 {
			hasThree = true
		}
	}

	if hasTwo && hasThree {
		return sum
	}

	return 0
}

func groupDice(dice []int) map[int]int {
	groups := map[int]int{}

	for _, die := range dice {
		groups[die]++
	}

	return groups
}
