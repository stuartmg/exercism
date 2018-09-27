package space

type Planet string

const earthSecondsPerYear = 31557600

// Given an age in seconds, calculate how old someone would be on the specified planet
func Age(age float64, planet Planet) float64 {
	return age / earthSecondsPerYear / planetModifier(planet)
}

func planetModifier(planet Planet) float64 {
	switch planet {
	case "Mercury":
		return 0.2408467
	case "Venus":
		return 0.61519726
	case "Mars":
		return 1.8808158
	case "Jupiter":
		return 11.862615
	case "Saturn":
		return 29.447498
	case "Uranus":
		return 84.016846
	case "Neptune":
		return 164.79132
	default:
		return 1
	}
}
