package pangram

import "strings"

const alphabet = "abcdefghijklmnopqrstuvwxyz"

func IsPangram(input string) bool {
	msg := strings.ToLower(input)

	for _, letter := range alphabet {
		if !strings.ContainsRune(msg, letter) {
			return false
		}
	}

	return true
}
