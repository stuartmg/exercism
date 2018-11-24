package diamond

import (
	"fmt"
	"strings"
)

func Gen(ch byte) (string, error) {
	if ch < 'A' || ch > 'Z' {
		return "", fmt.Errorf("Invalid character: %c", ch)
	}

	depth := int(ch - 'A')
	tree := make([]string, depth*2+1)

	for i := 0; i <= depth; i++ {
		line := make([]rune, depth*2+1)

		for idx, _ := range line {
			if depth-i == idx || depth+i == idx {
				line[idx] = rune('A' + i)
			} else {
				line[idx] = ' '
			}
		}

		tree[i] = string(line)
		tree[2*depth-i] = string(line)
	}

	return strings.Join(tree, "\n") + "\n", nil
}
