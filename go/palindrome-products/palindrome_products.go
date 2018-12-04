package palindrome

import (
	"fmt"
	"sort"
	"strconv"
)

type Product struct {
	Product        int
	Factorizations [][2]int
}

func Products(fmin int, fmax int) (Product, Product, error) {
	if fmin > fmax {
		return Product{}, Product{}, fmt.Errorf("fmin > fmax...")
	}

	palindromes := map[int][][2]int{}

	for i := fmin; i <= fmax; i++ {
		for j := i; j <= fmax; j++ {
			product := i * j

			if !isPalindrome(product) {
				continue
			}

			factorization := [2]int{i, j}

			if _, ok := palindromes[product]; !ok {
				palindromes[product] = [][2]int{factorization}
			} else {
				palindromes[product] = append(palindromes[product], factorization)
			}
		}
	}

	if len(palindromes) == 0 {
		return Product{}, Product{}, fmt.Errorf("no palindromes...")
	}

	keys := keys(palindromes)
	min := keys[0]
	max := keys[len(keys)-1]

	return Product{min, palindromes[min]}, Product{max, palindromes[max]}, nil
}

func isPalindrome(product int) bool {
	str := strconv.Itoa(product)
	length := len(str)

	for i := 0; i < length/2; i++ {
		if str[i] != str[length-1-i] {
			return false
		}
	}

	return true
}

func keys(palindromes map[int][][2]int) []int {
	keys := make([]int, 0, len(palindromes))

	for key, _ := range palindromes {
		keys = append(keys, key)
	}

	sort.Ints(keys)
	return keys
}
