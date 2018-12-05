package ocr

import "strings"

var lookup map[string]string = map[string]string{
	" _ \n| |\n|_|\n   ": "0",
	"   \n  |\n  |\n   ": "1",
	" _ \n _|\n|_ \n   ": "2",
	" _ \n _|\n _|\n   ": "3",
	"   \n|_|\n  |\n   ": "4",
	" _ \n|_ \n _|\n   ": "5",
	" _ \n|_ \n|_|\n   ": "6",
	" _ \n  |\n  |\n   ": "7",
	" _ \n|_|\n|_|\n   ": "8",
	" _ \n|_|\n _|\n   ": "9",
}

func Recognize(input string) []string {
	lines := strings.Split(input[1:], "\n")
	results := make([]string, 0, len(lines[0])/3)

	for line := 0; line < len(lines); line += 4 {
		results = append(results, recognizeRow(lines[line:line+4]))
	}

	return results
}

func recognizeRow(rows []string) string {
	results := make([]string, 0, len(rows[0])/3)

	for ch := 0; ch < len(rows[0]); ch += 3 {
		for i := ch; i < ch+3; i += 3 {
			digit := make([]string, 4)
			for idx, row := range rows {
				digit[idx] = row[i : i+3]
			}
			results = append(results, recognizeDigit(strings.Join(digit, "\n")))
		}
	}

	return strings.Join(results, "")
}

func recognizeDigit(input string) string {
	if val, ok := lookup[input]; ok {
		return val
	}

	return "?"
}
