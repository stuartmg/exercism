package matrix

import (
	"errors"
	"strconv"
	"strings"
)

type Matrix struct {
	data [][]int
}

func (m *Matrix) Rows() [][]int {
	dup := make([][]int, 0, len(m.data))
	for _, row := range m.data {
		dupRow := make([]int, len(row))
		copy(dupRow, row)
		dup = append(dup, dupRow)
	}
	return dup
}

func (m *Matrix) Cols() [][]int {
	rows := m.data
	cols := make([][]int, 0, len(rows[0]))

	for i := 0; i < len(rows[0]); i++ {
		cols = append(cols, make([]int, len(rows)))
	}

	for i, row := range m.data {
		for j, col := range row {
			cols[j][i] = col
		}
	}

	return cols
}

func (m *Matrix) Set(row int, col int, val int) bool {
	if row < 0 || row >= len(m.data) || col < 0 || col >= len(m.data[0]) {
		return false
	}

	m.data[row][col] = val
	return true
}

func New(input string) (*Matrix, error) {
	lines := strings.Split(input, "\n")
	data := make([][]int, 0, len(lines))

	for _, line := range lines {
		tokens := strings.Split(line, " ")
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
