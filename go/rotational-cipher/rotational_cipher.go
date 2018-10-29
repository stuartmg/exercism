package rotationalcipher

func RotationalCipher(plain string, rotations int) string {
	encrypted := []rune{}

	for _, ch := range plain {
		switch {
		case ch >= 'A' && ch <= 'Z':
			encrypted = append(encrypted, rotate(ch, 'A', rotations))
		case ch >= 'a' && ch <= 'z':
			encrypted = append(encrypted, rotate(ch, 'a', rotations))
		default:
			encrypted = append(encrypted, ch)
		}
	}

	return string(encrypted)
}

func rotate(ch rune, start rune, rotations int) rune {
	return rune((int(ch-start)+rotations)%26 + int(start))
}
