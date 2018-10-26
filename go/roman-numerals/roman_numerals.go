package romannumerals

import "errors"

func ToRomanNumeral(num int) (string, error) {
	roman := make([]rune, 0, 6)
	arabic := num

	if arabic < 1 || arabic > 3000 {
		return "", errors.New("Arabic number must be between 1 and 3000")
	}

	for arabic > 0 {
		switch {
		case arabic >= 1000:
			roman = append(roman, 'M')
			arabic -= 1000
		case arabic >= 900:
			roman = append(roman, 'C', 'M')
			arabic -= 900
		case arabic >= 500:
			roman = append(roman, 'D')
			arabic -= 500
		case arabic >= 400:
			roman = append(roman, 'C', 'D')
			arabic -= 400
		case arabic >= 100:
			roman = append(roman, 'C')
			arabic -= 100
		case arabic >= 90:
			roman = append(roman, 'X', 'C')
			arabic -= 90
		case arabic >= 50:
			roman = append(roman, 'L')
			arabic -= 50
		case arabic >= 40:
			roman = append(roman, 'X', 'L')
			arabic -= 40
		case arabic >= 10:
			roman = append(roman, 'X')
			arabic -= 10
		case arabic >= 9:
			roman = append(roman, 'I', 'X')
			arabic -= 9
		case arabic >= 5:
			roman = append(roman, 'V')
			arabic -= 5
		case arabic >= 4:
			roman = append(roman, 'I', 'V')
			arabic -= 4
		default:
			roman = append(roman, 'I')
			arabic -= 1
		}
	}

	return string(roman), nil
}
