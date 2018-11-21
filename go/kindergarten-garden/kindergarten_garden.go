package kindergarten

import (
	"fmt"
	"sort"
	"strings"
)

type Garden map[string][]string

func (g *Garden) Plants(child string) ([]string, bool) {
	plants, ok := (*g)[child]
	return plants, ok
}

func NewGarden(diagram string, children []string) (*Garden, error) {
	rows, err := parseDiagram(diagram)
	if err != nil {
		return nil, err
	}

	kids := sortedChildren(children)
	garden := Garden{}

	for idx, child := range kids {
		if _, exists := garden[child]; exists {
			return nil, fmt.Errorf("Duplicate names found: %v", children)
		}

		offset := idx * 2
		plants := make([]string, 0, 4)

		plants = append(plants, plantName(rows[0][offset]))
		plants = append(plants, plantName(rows[0][offset+1]))
		plants = append(plants, plantName(rows[1][offset]))
		plants = append(plants, plantName(rows[1][offset+1]))

		garden[child] = plants
	}

	return &garden, nil
}

func parseDiagram(diagram string) ([]string, error) {
	if strings.Index(diagram, "\n") != 0 {
		return nil, fmt.Errorf("Invalid diagram: %s", diagram)
	}

	if diagram != strings.ToUpper(diagram) {
		return nil, fmt.Errorf("Invalid diagram: %s", diagram)
	}

	rows := strings.Split(diagram[1:], "\n")

	if len(rows[0]) != len(rows[1]) || len(rows[0])%2 != 0 {
		return nil, fmt.Errorf("Invalid diagram: %s", diagram)
	}

	return rows, nil
}

func sortedChildren(children []string) []string {
	// duplicate children so that we don't modify the original slice
	kids := make([]string, len(children))
	copy(kids, children)
	sort.Strings(kids)

	return kids
}

func plantName(abbrev byte) string {
	switch abbrev {
	case 'C':
		return "clover"
	case 'G':
		return "grass"
	case 'R':
		return "radishes"
	case 'V':
		return "violets"
	default:
		return ""
	}
}
