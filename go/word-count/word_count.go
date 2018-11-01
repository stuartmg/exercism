package wordcount

import (
	"strings"
	"unicode"
)

type Frequency map[string]int

func WordCount(input string) Frequency {
	freq := Frequency{}

	words := strings.FieldsFunc(strings.ToLower(input), func(r rune) bool {
		return !unicode.IsLetter(r) && !unicode.IsDigit(r) && r != '\''
	})

	for _, word := range words {
		if word != "" {
			freq[strings.Trim(word, "'")]++
		}
	}

	return freq
}
