package lsproduct

import "errors"

func LargestSeriesProduct(digits string, span int) (int64, error) {
	if len(digits) < span {
		return -1, errors.New("Span can't be longer than string")
	}

	if span < 0 {
		return -1, errors.New("Span can't be negative")
	}

	product := 0

	for i := 0; i <= len(digits)-span; i++ {
		prod, err := sum(digits[i : i+span])
		if err != nil {
			return -1, err
		}

		if prod > product {
			product = prod
		}
	}

	return int64(product), nil
}

func sum(digits string) (int, error) {
	sum := 1

	for _, ch := range digits {
		if ch < '0' || ch > '9' {
			return -1, errors.New("Invalid string")
		}
		sum *= int(ch - '0')
	}

	return sum, nil
}
