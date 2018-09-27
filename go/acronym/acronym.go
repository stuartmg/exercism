package acronym

import (
	"strings"
	"unicode"
)

// Convert a phrase to its acronym
func Abbreviate(s string) string {
	words := strings.FieldsFunc(strings.ToUpper(s), split)

	for idx, word := range words {
		words[idx] = word[:1]
	}

	return strings.Join(words, "")
}

func split(r rune) bool {
	return r == '-' || unicode.IsSpace(r)
}
