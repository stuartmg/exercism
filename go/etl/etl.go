package etl

import "strings"

// Transform from the old scrabble scoring system to the new
// scrabble scoring system
func Transform(old map[int][]string) map[string]int {
	scoreMap := make(map[string]int)
	for points, letters := range old {
		for _, letter := range letters {
			scoreMap[strings.ToLower(letter)] = points
		}
	}
	return scoreMap
}
