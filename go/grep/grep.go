package grep

import (
	"bufio"
	"os"
	"strconv"
	"strings"
)

type options struct {
	lineNumbers bool
	fileNames   bool
	ignoreCase  bool
	invertMatch bool
	matchLine   bool
}

// Search files for lines matching the query
//
// Flags:
// -n Print the line numbers of each matching line.
// -l Print only the names of files that contain at least one matching line.
// -i Match line using a case-insensitive comparison.
// -v Invert the program -- collect all lines that fail to match the pattern.
// -x Only match entire lines, instead of lines that contain a match.
func Search(query string, flags []string, files []string) []string {
	matches := make([]string, 0, len(files))
	opts := parseFlags(flags)

	for _, file := range files {
		searchFile(file, func(line int, text string) {
			tokens := make([]string, 0, 5)

			matched := match(text, query, opts)

			if opts.invertMatch {
				matched = !matched
			}

			if !matched {
				return
			}

			if len(files) > 1 && !opts.fileNames {
				tokens = append(tokens, file)
			}

			if opts.lineNumbers {
				tokens = append(tokens, strconv.Itoa(line))
			}

			if opts.fileNames {
				tokens = append(tokens, file)
			} else {
				tokens = append(tokens, text)
			}

			matches = appendMatch(matches, strings.Join(tokens, ":"))
		})
	}

	return matches
}

func searchFile(filename string, fn func(int, string)) {
	file, err := os.Open(filename)
	if err != nil {
		return
	}
	defer file.Close()

	line := 0
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line++
		fn(line, scanner.Text())
	}

	return
}

func match(text string, query string, opts options) bool {
	if opts.ignoreCase {
		text = strings.ToLower(text)
		query = strings.ToLower(query)
	}

	if opts.matchLine {
		return text == query
	}

	return strings.Index(text, query) >= 0
}

func parseFlags(flags []string) options {
	opts := options{}

	for _, flag := range flags {
		switch flag {
		case "-n":
			opts.lineNumbers = true
		case "-l":
			opts.fileNames = true
		case "-i":
			opts.ignoreCase = true
		case "-v":
			opts.invertMatch = true
		case "-x":
			opts.matchLine = true
		}
	}

	return opts
}

func appendMatch(matches []string, match string) []string {
	for _, s := range matches {
		if s == match {
			return matches
		}
	}

	return append(matches, match)
}
