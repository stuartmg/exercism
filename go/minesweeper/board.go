package minesweeper

import (
	"bytes"
	"errors"
	"strings"
)

type Board [][]byte

func (b Board) Count() error {
	if !b.valid() {
		return errors.New("Invalid board")
	}

	if len(b) == 2 {
		return nil
	}

	for row := 1; row < len(b)-1; row++ {
		for col := 1; col < len(b[row])-1; col++ {
			if b[row][col] == '*' {
				continue
			}

			mines := b.numberOfAdjacentMines(row, col)
			if mines > 0 {
				b[row][col] = byte('0' + mines)
			}
		}
	}

	return nil
}

func (b Board) String() string {
	return "\n" + string(bytes.Join(b, []byte{'\n'}))
}

func (b Board) valid() bool {
	rows := len(b)
	cols := len(b[0])

	if rows < 2 || cols < 2 {
		return false
	}

	// make sure first and last row are borders
	border := "+" + strings.Repeat("-", cols-2) + "+"
	if string(b[0]) != border || string(b[rows-1]) != border {
		return false
	}

	for r := 1; r < rows-1; r++ {
		// make sure first and last column are borders
		if b[r][0] != '|' || b[r][cols-1] != '|' {
			return false
		}

		// make sure the other columns are either empty or mine
		for c := 1; c <= cols-2; c++ {
			if b[r][c] != ' ' && b[r][c] != '*' {
				return false
			}
		}
	}

	return true
}

func (b Board) numberOfAdjacentMines(row int, col int) int {
	count := 0

	for r := row - 1; r <= row+1; r++ {
		for c := col - 1; c <= col+1; c++ {
			if b[r][c] == '*' {
				count++
			}
		}
	}

	return count
}
