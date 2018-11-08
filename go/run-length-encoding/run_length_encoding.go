// Implement run-length encoding and decoding.
package encode

import (
	"fmt"
	"strconv"
	"strings"
)

// compress input by removing consecutive duplicate letters
func RunLengthEncode(input string) string {
	if len(input) == 0 {
		return ""
	}

	output := make([]string, 0, len(input))
	counter := 1

	for i := 1; i < len(input); i++ {
		if input[i] != input[i-1] {
			if counter == 1 {
				output = append(output, string(input[i-1]))
			} else {
				output = append(output, fmt.Sprintf("%d%c", counter, input[i-1]))
			}
			counter = 1
		} else {
			counter++
		}
	}

	last := len(input) - 1
	if counter == 1 {
		output = append(output, string(input[last]))
	} else {
		output = append(output, fmt.Sprintf("%d%c", counter, input[last]))
	}

	return strings.Join(output, "")
}

// decompress input by replacing encoded format with consecutive duplicate letters
func RunLengthDecode(input string) string {
	output := make([]string, 0, len(input))
	count := 1

	for len(input) > 0 {
		// process leading space or sscanf will swallow it
		if input[0] == ' ' {
			output = append(output, string(input[0]))
			input = input[1:]
			continue
		}

		_, err := fmt.Sscanf(input, "%d", &count)
		if err == nil {
			input = input[len(strconv.Itoa(count)):]
		}

		output = append(output, strings.Repeat(string(input[0]), count))

		count = 1
		input = input[1:]
	}

	return strings.Join(output, "")
}
