package beer

import (
	"errors"
	"fmt"
	"strings"
)

func Song() string {
	song, _ := Verses(99, 0)
	return song
}

func Verses(start int, stop int) (string, error) {
	if start < 0 || stop < 0 {
		return "", errors.New("invalid start or stop verse")
	}
	if start < stop {
		return "", errors.New("starting verse must be before ending verse")
	}

	verses := make([]string, 0, start-stop)
	for i := start; i >= stop; i-- {
		verse, err := Verse(i)
		if err != nil {
			return "", err
		}
		verses = append(verses, verse)
	}

	return strings.Join(verses, "\n") + "\n", nil
}

func Verse(num int) (string, error) {
	if num > 99 {
		return "", errors.New("There is only space for 99 bottles")
	}

	switch num {
	case 0:
		return "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n", nil
	case 1:
		return "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n", nil
	case 2:
		return "2 bottles of beer on the wall, 2 bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n", nil
	default:
		return fmt.Sprintf("%d bottles of beer on the wall, %d bottles of beer.\nTake one down and pass it around, %d bottles of beer on the wall.\n", num, num, num-1), nil
	}
}
