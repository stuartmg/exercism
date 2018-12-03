package foodchain

import (
	"fmt"
	"strings"
)

type verse struct {
	name    string
	phrase  string
	postfix string
}

var animals []verse = []verse{
	verse{"fly", "", ". Perhaps she'll die"},
	verse{"spider", "It wriggled and jiggled and tickled inside her.", ""},
	verse{"bird", "How absurd to swallow a bird!", " that wriggled and jiggled and tickled inside her"},
	verse{"cat", "Imagine that, to swallow a cat!", ""},
	verse{"dog", "What a hog, to swallow a dog!", ""},
	verse{"goat", "Just opened her throat and swallowed a goat!", ""},
	verse{"cow", "I don't know how she swallowed a cow!", ""},
	verse{"horse", "She's dead, of course!", ""},
}

func Song() string {
	return Verses(1, len(animals))
}

func Verses(start int, finish int) string {
	versus := make([]string, 0, finish-start)

	for i := start; i <= finish; i++ {
		versus = append(versus, Verse(i))
	}

	return strings.Join(versus, "\n\n")
}

func Verse(num int) string {
	verse := make([]string, 0, 3)

	verse = append(verse, fmt.Sprintf("I know an old lady who swallowed a %s.", animals[num-1].name))

	if animals[num-1].phrase != "" {
		verse = append(verse, animals[num-1].phrase)
	}

	if num < len(animals) {
		for i := num - 1; i >= 0; i-- {
			lines := make([]string, 0, 2)

			if i > 0 {
				lines = append(lines, fmt.Sprintf("She swallowed the %s to catch the %s", animals[i].name, animals[i-1].name))
			} else {
				lines = append(lines, fmt.Sprintf("I don't know why she swallowed the %s", animals[i].name))
			}

			lines = append(lines, fmt.Sprintf("%s.", animals[i].postfix))

			verse = append(verse, strings.Join(lines, ""))
		}
	}

	return strings.Join(verse, "\n")
}
