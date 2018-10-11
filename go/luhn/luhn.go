package luhn

import (
	"strconv"
	"strings"
)

func Valid(cardNumber string) bool {
	cc := strings.TrimSpace(cardNumber)

	if len(cc) < 2 {
		return false
	}

	double := false
	sum := 0
	var char byte

	for i := len(cc); i > 0; i-- {
		char = cc[i-1]

		if char == ' ' {
			continue
		}

		if char < '0' || char > '9' {
			return false
		}

		digit, _ := strconv.Atoi(string(char))

		sum += adjustNumber(digit, double)
		double = !double
	}

	return sum%10 == 0
}

func adjustNumber(num int, double bool) int {
	val := num
	if double {
		val = val * 2
	}
	if val > 9 {
		val -= 9
	}
	return val
}
