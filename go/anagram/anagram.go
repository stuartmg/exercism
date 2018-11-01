package anagram

import (
	"sort"
	"strings"
)

// Given a word and a list of possible anagrams, select the correct sublist.
func Detect(subject string, candidates []string) []string {
	orig := strings.ToLower(subject)
	target := sortLetters(orig)

	matches := make([]string, 0, len(candidates))

	for _, word := range candidates {
		w := strings.ToLower(word)
		if target == sortLetters(w) && orig != w {
			matches = append(matches, word)
		}
	}

	return matches
}

func sortLetters(s string) string {
	input := []rune(s)
	sort.Slice(input, func(i, j int) bool {
		return input[i] < input[j]
	})
	return string(input)
}
