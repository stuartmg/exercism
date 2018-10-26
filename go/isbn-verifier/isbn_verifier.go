package isbn

func IsValidISBN(isbn string) bool {
	sum, multiplier := 0, 10
	for idx, num := range isbn {
		if num >= '0' && num <= '9' {
			sum += int(num-'0') * multiplier
			multiplier--
		} else if idx == len(isbn)-1 && num == 'X' {
			sum += 10 * multiplier
			multiplier--
		}
	}

	return sum%11 == 0 && multiplier == 0
}
