package accumulate

func Accumulate(values []string, fn func(string) string) []string {
	results := make([]string, len(values))
	for idx, val := range values {
		results[idx] = fn(val)
	}
	return results
}
