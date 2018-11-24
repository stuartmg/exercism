package transpose

func Transpose(input []string) []string {
	temp := [][]rune{}

	for r, row := range input {
		for c, ch := range row {
			for len(temp) <= c {
				temp = append(temp, make([]rune, 0, len(input)))
			}

			for len(temp[c]) < r {
				temp[c] = append(temp[c], ' ')
			}

			temp[c] = append(temp[c], ch)
		}
	}

	results := []string{}

	for _, row := range temp {
		results = append(results, string(row))
	}

	return results
}
