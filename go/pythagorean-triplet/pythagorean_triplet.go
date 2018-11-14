package pythagorean

type Triplet [3]int

func Range(min int, max int) []Triplet {
	triplets := make([]Triplet, 0, 5)

	for a := min; a <= max; a++ {
		for b := a; b <= max; b++ {
			for c := b; c <= max; c++ {
				if a*a+b*b == c*c {
					triplets = append(triplets, Triplet{a, b, c})
				}
			}
		}
	}

	return triplets
}

func Sum(p int) []Triplet {
	triplets := make([]Triplet, 0, 5)

	for _, triplet := range Range(1, p) {
		if triplet[0]+triplet[1]+triplet[2] == p {
			triplets = append(triplets, triplet)
		}
	}

	return triplets
}
