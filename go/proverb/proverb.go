package proverb

import "fmt"

// Given a list of inputs, generate the relevant proverb
func Proverb(rhyme []string) []string {
	parts := make([]string, 0, len(rhyme))

	for i := 0; i < len(rhyme)-1; i++ {
		parts = append(parts, fmt.Sprintf("For want of a %s the %s was lost.", rhyme[i], rhyme[i+1]))
	}

	if len(rhyme) > 0 {
		parts = append(parts, fmt.Sprintf("And all for the want of a %s.", rhyme[0]))
	}

	return parts
}
