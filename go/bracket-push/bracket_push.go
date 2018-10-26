// Bracket matching check system
package brackets

// Test that brackets, parenthesis, and braces are all properly matched and nested
func Bracket(input string) (bool, error) {
	stack := make([]rune, 0, len(input)/2)
	bracketMap := map[rune]rune{
		']': '[',
		')': '(',
		'}': '{',
	}

	for _, letter := range input {
		switch letter {
		case '[', '(', '{':
			stack = append(stack, letter)
		case ']', ')', '}':
			if len(stack) > 0 && stack[len(stack)-1] == bracketMap[letter] {
				stack = stack[:len(stack)-1]
			} else {
				return false, nil
			}
		}
	}

	// non-empty stack means something didn't match, so error
	return len(stack) == 0, nil
}
