package piglatin

import "strings"

func Sentence(input string) string {
	words := strings.Fields(input)
	sentence := make([]string, 0, len(words))

	for _, word := range words {
		sentence = append(sentence, convert(word))
	}

	return strings.Join(sentence, " ")
}

func convert(input string) string {
	if startsWithVowel(input) {
		return input + "ay"
	}

	if len(input) > 3 && (input[:3] == "squ" || input[:3] == "sch" || input[:3] == "thr") {
		return input[3:] + input[:3] + "ay"
	}

	if len(input) > 2 && (input[:2] == "ch" || input[:2] == "qu" || input[:2] == "rh" || input[:2] == "th") {
		return input[2:] + input[:2] + "ay"
	}

	return input[1:] + input[:1] + "ay"
}

func startsWithVowel(input string) bool {
	c := input[0]
	d := input[:1]

	if len(input) > 1 {
		d = input[:2]
	}

	return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' || d == "xr" || d == "yt"
}
