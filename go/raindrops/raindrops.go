package raindrops

import (
	"strconv"
	"strings"
)

func Convert(num int) string {
	sounds := make([]string, 0, 3)

	if num%3 == 0 {
		sounds = append(sounds, "Pling")
	}

	if num%5 == 0 {
		sounds = append(sounds, "Plang")
	}

	if num%7 == 0 {
		sounds = append(sounds, "Plong")
	}

	if len(sounds) == 0 {
		return strconv.Itoa(num)
	}

	return strings.Join(sounds, "")
}
