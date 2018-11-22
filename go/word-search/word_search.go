package wordsearch

import (
	"errors"
	"strings"
)

func Solve(words []string, puzzle []string) (map[string][2][2]int, error) {
	results := make(map[string][2][2]int)

	for _, word := range words {
		if coords, ok := findWord(word, puzzle); ok {
			results[word] = coords
		}
	}

	if len(results) != len(words) {
		return results, errors.New("not all words found")
	}

	return results, nil
}

func findWord(word string, puzzle []string) ([2][2]int, bool) {
	reversed := reverse(word)

	// check rows for matches
	for idx, row := range puzzle {
		if i := strings.Index(row, word); i >= 0 {
			return [2][2]int{{i, idx}, {i + len(word) - 1, idx}}, true
		}

		if i := strings.Index(row, reversed); i >= 0 {
			return [2][2]int{{i + len(word) - 1, idx}, {i, idx}}, true
		}
	}

	// check columns for matches
	for idx := 0; idx < len(puzzle[0]); idx++ {
		col := column(idx, puzzle)

		if i := strings.Index(col, word); i >= 0 {
			return [2][2]int{{idx, i}, {idx, i + len(word) - 1}}, true
		}

		if i := strings.Index(col, reverse(word)); i >= 0 {
			return [2][2]int{{idx, i + len(word) - 1}, {idx, i}}, true
		}
	}

	// check diagnal
	for r, row := range puzzle {
		for c, _ := range row {
			diag := topLeftToBottomRight(r, c, len(word), puzzle)

			if diag == word {
				return [2][2]int{{c, r}, {c + len(word) - 1, r + len(word) - 1}}, true
			}

			if diag == reversed {
				return [2][2]int{{c + len(word) - 1, r + len(word) - 1}, {c, r}}, true
			}

			diag = topRightToBottomLeft(r, c, len(word), puzzle)

			if diag == word {
				return [2][2]int{{c, r}, {c - len(word) + 1, r + len(word) - 1}}, true
			}

			if diag == reversed {
				return [2][2]int{{c - len(word) + 1, r + len(word) - 1}, {c, r}}, true
			}
		}
	}

	return [2][2]int{}, false
}

func reverse(word string) string {
	reversed := make([]byte, 0, len(word))

	for i := len(word) - 1; i >= 0; i-- {
		reversed = append(reversed, word[i])
	}

	return string(reversed)
}

func column(col int, puzzle []string) string {
	chars := make([]byte, 0, len(puzzle))

	for _, row := range puzzle {
		chars = append(chars, row[col])
	}

	return string(chars)
}

func topLeftToBottomRight(row int, col int, length int, puzzle []string) string {
	if len(puzzle) <= row+length || len(puzzle[0]) <= col+length {
		return ""
	}

	chars := make([]byte, 0, length)

	for i := 0; i < length; i++ {
		chars = append(chars, puzzle[row+i][col+i])
	}

	return string(chars)
}

func topRightToBottomLeft(row int, col int, length int, puzzle []string) string {
	if len(puzzle) <= row+length || col-length < 0 {
		return ""
	}

	chars := make([]byte, 0, length)

	for i := 0; i < length; i++ {
		chars = append(chars, puzzle[row+i][col-i])
	}

	return string(chars)
}
