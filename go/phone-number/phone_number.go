// Clean up user-entered phone numbers so that they can be sent SMS messages.
package phonenumber

import (
	"errors"
	"fmt"
	"strings"
)

var InvalidNumber error = errors.New("Invalid number")

// return an unformatted cleaned up number
func Number(input string) (string, error) {
	number := clean(input)

	if len(number) < 10 || len(number) > 11 {
		return "", InvalidNumber
	}

	if len(number) == 11 && number[0] != '1' {
		return "", InvalidNumber
	}

	if len(number) == 11 {
		number = number[1:]
	}

	// invalid if area code starts with 0 or 1
	if number[0] == '0' || number[0] == '1' {
		return "", InvalidNumber
	}

	// invalid if exchange starts with 0 or 1
	if number[3] == '0' || number[3] == '1' {
		return "", InvalidNumber
	}

	return number, nil
}

// return the area code for a number
func AreaCode(input string) (string, error) {
	number, err := Number(input)
	if err != nil {
		return "", err
	}

	return number[0:3], nil
}

// return a formatted version of the number - e.g. (###) ###-####
func Format(input string) (string, error) {
	number, err := Number(input)
	if err != nil {
		return "", err
	}

	return fmt.Sprintf("(%s) %s-%s", number[:3], number[3:6], number[6:]), nil
}

func clean(input string) string {
	return strings.Map(func(ch rune) rune {
		if ch >= '0' && ch <= '9' {
			return ch
		}
		return -1
	}, input)
}
