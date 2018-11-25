package matrix

import (
	"errors"
	"strconv"
	"strings"
)

type Pair struct {
	row int
	col int
}

type Matrix struct {
	data [][]int
}

func (m *Matrix) Saddle() []Pair {
	points := []Pair{}

	for r, row := range m.data {
		for c, val := range row {
			if m.smallestInColumn(c, val) && m.largestInRow(r, val) {
				points = append(points, Pair{r, c})
			}
		}
	}

	return points
}

func (m *Matrix) smallestInColumn(col int, val int) bool {
	for _, row := range m.data {
		if row[col] < val {
			return false
		}
	}

	return true
}

func (m *Matrix) largestInRow(row int, val int) bool {
	for _, v := range m.data[row] {
		if v > val {
			return false
		}
	}

	return true
}

func New(input string) (*Matrix, error) {
	lines := strings.Split(input, "\n")
	data := make([][]int, 0, len(lines))

	for _, line := range lines {
		tokens := strings.Fields(line)
		nums := make([]int, 0, len(tokens))

		for _, num := range tokens {
			if num == "" {
				continue
			}

			val, err := strconv.Atoi(num)
			if err != nil {
				return nil, errors.New("Invalid matrix")
			}

			nums = append(nums, val)
		}

		data = append(data, nums)
	}

	// make sure all arrays are the same length
	cols := len(data[0])
	for i := 1; i < len(data); i++ {
		if len(data[i]) != cols {
			return nil, errors.New("Invalid matrix")
		}
	}

	return &Matrix{data: data}, nil
}
