// Translate RNA sequences into proteins.
package protein

import "errors"

var (
	STOP           error = errors.New("STOP")
	ErrInvalidBase error = errors.New("Invalid codon")
)

// Convert a codon into a protein
func FromCodon(codon string) (string, error) {
	switch codon {
	case "AUG":
		return "Methionine", nil
	case "UUU", "UUC":
		return "Phenylalanine", nil
	case "UUA", "UUG":
		return "Leucine", nil
	case "UCU", "UCC", "UCA", "UCG":
		return "Serine", nil
	case "UAU", "UAC":
		return "Tyrosine", nil
	case "UGU", "UGC":
		return "Cysteine", nil
	case "UGG":
		return "Tryptophan", nil
	case "UAA", "UAG", "UGA":
		return "", STOP
	default:
		return "", ErrInvalidBase
	}
}

// Convert an RNA strand into an array of proteins
func FromRNA(strand string) ([]string, error) {
	proteins := make([]string, 0, len(strand)/3)

	for i := 0; i < len(strand); i += 3 {
		protein, err := FromCodon(strand[i : i+3])

		if err == STOP {
			break
		}

		if err != nil {
			return proteins, err
		}

		proteins = append(proteins, protein)
	}

	return proteins, nil
}
