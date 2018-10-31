package cryptosquare

import (
	"math"
	"strings"
)

func Encode(plain string) string {
	if len(plain) == 0 {
		return ""
	}

	return strings.Join(crypt(square(normalize(plain))), " ")
}

func normalize(input string) string {
	normalized := make([]rune, 0, len(input))

	for _, ch := range strings.ToLower(input) {
		if (ch >= 'a' && ch <= 'z') || (ch >= '0' && ch <= '9') {
			normalized = append(normalized, ch)
		}
	}

	return string(normalized)
}

func square(input string) []string {
	cols, rows := columnsAndRows(input)

	square := make([]string, 0, rows)

	for i := 0; i < rows; i++ {
		offset := cols * i

		if offset+cols > len(input) {
			square = append(square, input[offset:])
		} else {
			square = append(square, input[offset:offset+cols])
		}
	}

	return square
}

func columnsAndRows(input string) (int, int) {
	cols := int(math.Ceil(math.Sqrt(float64(len(input)))))
	rows := len(input) / cols

	if len(input)%cols > 0 {
		rows++
	}

	return cols, rows
}

func crypt(square []string) []string {
	cols := len(square[0])
	rows := len(square)
	crypt := make([]string, 0, cols)

	for col := 0; col < cols; col++ {
		temp := make([]rune, 0, rows)

		for _, row := range square {
			if col > len(row)-1 {
				temp = append(temp, ' ')
			} else {
				temp = append(temp, rune(row[col]))
			}
		}

		crypt = append(crypt, string(temp))
	}

	return crypt
}
