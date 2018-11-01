package strand

import "strings"

func ToRNA(dna string) string {
	fn := func(r rune) rune {
		switch r {
		case 'A':
			return 'U'
		case 'C':
			return 'G'
		case 'G':
			return 'C'
		case 'T':
			return 'A'
		default:
			return -1
		}
	}

	return strings.Map(fn, dna)
}
