package perfect

import "errors"

type Classification int

const (
	ClassificationPerfect = iota
	ClassificationAbundant
	ClassificationDeficient
)

var ErrOnlyPositive = errors.New("Only positive numbers")

func Classify(number int64) (Classification, error) {
	if number < int64(1) {
		return ClassificationPerfect, ErrOnlyPositive
	}

	if number == 1 {
		return ClassificationDeficient, nil
	}

	// always include 1 as a factor
	sum := int64(1)

	// add up the factors
	for i := int64(2); i*i < number; i++ {
		if number%i == 0 {
			sum += i
			if i*i < number {
				sum += number / i
			}
		}
	}

	switch {
	case sum < number:
		return ClassificationDeficient, nil
	case sum > number:
		return ClassificationAbundant, nil
	default:
		return ClassificationPerfect, nil
	}
}
