// bob the lackadaisical teenager
package bob

import "strings"

// get bob's response to a remark
func Hey(remark string) string {
	r := strings.TrimSpace(remark)

	if isSilence(r) {
		return "Fine. Be that way!"
	}

	if isYelling(r) {
		if isQuestion(r) {
			return "Calm down, I know what I'm doing!"
		} else {
			return "Whoa, chill out!"
		}
	}

	if isQuestion(r) {
		return "Sure."
	}

	return "Whatever."
}

func isSilence(remark string) bool {
	return len(remark) == 0
}

func isYelling(remark string) bool {
	return strings.ToUpper(remark) == remark && strings.ToLower(remark) != remark
}

func isQuestion(remark string) bool {
	return strings.HasSuffix(remark, "?")
}
