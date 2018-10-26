// Determine if a triangle is equilateral, isosceles, or scalene.
package triangle

import "math"

type Kind int

const (
	NaT = iota // not a triangle
	Equ        // equilateral
	Iso        // isosceles
	Sca        // scalene
)

// Determine the kind of trangle based on the provided side lengths
func KindFromSides(a, b, c float64) Kind {
	if isInvalid(a, b, c) || inequality(a, b, c) {
		return NaT
	}

	if a == b && b == c {
		return Equ
	}

	if (a == b) || (b == c) || (a == c) {
		return Iso
	}

	return Sca
}

func isInvalid(nums ...float64) bool {
	for _, num := range nums {
		if math.IsNaN(num) || math.IsInf(num, 0) || num <= 0 {
			return true
		}
	}
	return false
}

func inequality(a, b, c float64) bool {
	return a+b < c || a+c < b || b+c < a
}
