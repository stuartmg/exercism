package hamming

import "errors"

func Distance(a, b string) (int, error) {
	if len(a) != len(b) {
		return -1, errors.New("strands must be of equal length")
	}

	distance := 0
	for idx := range a {
		if a[idx] != b[idx] {
			distance++
		}
	}

	return distance, nil
}
