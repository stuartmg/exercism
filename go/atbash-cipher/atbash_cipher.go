package atbash

import "strings"

func Atbash(plain string) string {
	encrypted := encrypt(plain)

	count := len(encrypted) / 5
	if len(encrypted)%5 > 0 {
		count++
	}

	groups := make([]string, count)
	for i := 0; i < count-1; i++ {
		groups[i] = encrypted[5*i : 5*(i+1)]
	}
	groups[count-1] = encrypted[5*(count-1):]

	return strings.Join(groups, " ")
}

func encrypt(input string) string {
	return strings.Map(func(ch rune) rune {
		if ch >= 'a' && ch <= 'z' {
			return 'z' - (ch - 'a')
		}

		if ch >= 'A' && ch <= 'Z' {
			lower := ('a' + ch - 'A')
			return 'z' - (lower - 'a')
		}

		if ch >= '0' && ch <= '9' {
			return ch
		}

		return -1
	}, input)
}
