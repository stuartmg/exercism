// various rotation ciphers
package cipher

import "strings"

type Cipher interface {
	Encode(string) string
	Decode(string) string
}

// caesar cipher - fixed rotation of 3 characters
func NewCaesar() Cipher {
	return NewShift(3)
}

// shift cipher - configurable number of characters to rotate
func NewShift(num int) Cipher {
	if num == 0 || num < -25 || num > 25 {
		return nil
	}
	if num < 0 {
		num = 26 + num
	}
	return Vigenere{shifts: []int{num}}
}

// vigenere cipher - uses a key string to give each character a different number of rotations
type Vigenere struct {
	shifts []int
}

func (c Vigenere) Encode(plain string) string {
	return shift(plain, func(ch rune, idx int) rune { return rotate(ch, 'a', c.shifts[idx%len(c.shifts)]) })
}

func (c Vigenere) Decode(crypt string) string {
	return shift(crypt, func(ch rune, idx int) rune { return rotate(ch, 'a', 26-c.shifts[idx%len(c.shifts)]) })
}

func NewVigenere(input string) Cipher {
	if len(input) == 0 {
		return nil
	}

	shifts := make([]int, 0, len(input))
	valid := false
	for _, ch := range input {
		if ch < 'a' || ch > 'z' {
			return nil
		}
		if ch != 'a' {
			valid = true
		}
		shifts = append(shifts, int(ch-'a'))
	}

	if !valid {
		return nil
	}

	return Vigenere{shifts: shifts}
}

func shift(plain string, fn func(rune, int) rune) string {
	results := make([]rune, 0, len(plain))
	idx := 0
	for _, ch := range strings.ToLower(plain) {
		if ch >= 'a' && ch <= 'z' {
			results = append(results, fn(ch, idx))
			idx++
		}
	}
	return string(results)
}

func rotate(ch rune, start rune, rotations int) rune {
	return rune((int(ch-start)+rotations)%26 + int(start))
}
