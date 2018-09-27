package twofer

import "fmt"

// ShareWith - One for you and one for me.
func ShareWith(name string) string {
	if name == "" {
		name = "you"
	}

	return fmt.Sprintf("One for %s, one for me.", name)
}
