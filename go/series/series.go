package series

func All(size int, s string) []string {
	results := []string{}

	for i := 0; i <= len(s)-size; i++ {
		results = append(results, s[i:i+size])
	}

	return results
}

func UnsafeFirst(size int, s string) string {
	return s[:size]
}

func First(size int, s string) (string, bool) {
	if size > len(s) {
		return "", false
	}

	return s[:size], true
}
