package secret

const (
	wink = 1 << iota
	blink
	eyes
	jump
	reverse
)

func Handshake(code uint) []string {
	results := make([]string, 0, 4)

	if code&reverse > 0 {
		results = appendAction(code, jump, "jump", results)
		results = appendAction(code, eyes, "close your eyes", results)
		results = appendAction(code, blink, "double blink", results)
		results = appendAction(code, wink, "wink", results)
	} else {
		results = appendAction(code, wink, "wink", results)
		results = appendAction(code, blink, "double blink", results)
		results = appendAction(code, eyes, "close your eyes", results)
		results = appendAction(code, jump, "jump", results)
	}

	return results
}

func appendAction(code uint, flag uint, action string, results []string) []string {
	if code&flag > 0 {
		return append(results, action)
	}

	return results
}
