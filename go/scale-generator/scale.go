package scale

import "strings"

var (
	sharps []string = []string{"A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"}
	flats  []string = []string{"A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab"}
)

func Scale(tonic string, interval string) []string {
	scale := scaleFor(tonic)
	if len(interval) == 0 {
		return scale
	}
	results := make([]string, 0, len(interval))
	idx := 0
	for _, step := range interval {
		results = append(results, scale[idx])
		switch step {
		case 'm':
			idx++
		case 'M':
			idx += 2
		case 'A':
			idx += 3
		}
	}
	return results
}

func scaleFor(tonic string) []string {
	var scale []string
	switch tonic {
	case "C", "G", "D", "A", "E", "B", "F#", "a", "e", "b", "f#", "c#", "g#", "d#":
		scale = sharps
	case "F", "Bb", "Eb", "Ab", "Db", "Gb", "d", "g", "c", "f", "bb", "eb":
		scale = flats
	}
	idx := indexOf(scale, tonic)
	return append(scale[idx:], scale[:idx]...)
}

func indexOf(scale []string, tonic string) int {
	t := strings.Title(tonic)
	for idx, note := range scale {
		if note == t {
			return idx
		}
	}
	return 0
}
