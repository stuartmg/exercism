package pascal

func Triangle(rows int) [][]int {
	triangle := make([][]int, rows)

	for i := 0; i < rows; i++ {
		line := make([]int, i+1)

		for j := 0; j < i+1; j++ {
			if j == 0 || j == i {
				line[j] = 1
			} else {
				line[j] = triangle[i-1][j-1] + triangle[i-1][j]
			}
		}

		triangle[i] = line
	}

	return triangle
}
