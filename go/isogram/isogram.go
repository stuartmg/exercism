package isogram

import "strings"

// return true if word is isogram
func IsIsogram(input string) bool {
	val := strings.ToLower(input)

	for idx, letter := range val {
		if letter == ' ' || letter == '-' {
			continue
		}

		if idx != strings.IndexRune(val, letter) {
			return false
		}
	}

	return true
}
