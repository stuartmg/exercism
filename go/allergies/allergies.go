package allergies

const (
	eggs = 1 << iota
	peanuts
	shellfish
	strawberries
	tomatoes
	chocolate
	pollen
	cats
)

var substances = []string{"eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats"}

func Allergies(score uint) []string {
	results := make([]string, 0, len(substances))

	for _, substance := range substances {
		if AllergicTo(score, substance) {
			results = append(results, substance)
		}
	}

	return results
}

func AllergicTo(score uint, substance string) bool {
	switch substance {
	case "eggs":
		return score&eggs > 0
	case "peanuts":
		return score&peanuts > 0
	case "shellfish":
		return score&shellfish > 0
	case "strawberries":
		return score&strawberries > 0
	case "tomatoes":
		return score&tomatoes > 0
	case "chocolate":
		return score&chocolate > 0
	case "pollen":
		return score&pollen > 0
	case "cats":
		return score&cats > 0
	default:
		return false
	}
}
