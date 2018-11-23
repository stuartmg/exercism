package house

import (
	"fmt"
	"strings"
)

type Part struct {
	subject string
	action  string
}

var parts = []Part{
	{subject: "the house that Jack built.", action: "lay in"},
	{subject: "the malt", action: "ate"},
	{subject: "the rat", action: "killed"},
	{subject: "the cat", action: "worried"},
	{subject: "the dog", action: "tossed"},
	{subject: "the cow with the crumpled horn", action: "milked"},
	{subject: "the maiden all forlorn", action: "kissed"},
	{subject: "the man all tattered and torn", action: "married"},
	{subject: "the priest all shaven and shorn", action: "woke"},
	{subject: "the rooster that crowed in the morn", action: "kept"},
	{subject: "the farmer sowing his corn", action: "belonged to"},
	{subject: "the horse and the hound and the horn", action: ""},
}

func Song() string {
	song := make([]string, 0, len(parts))

	for idx, _ := range parts {
		song = append(song, Verse(idx+1))
	}

	return strings.Join(song, "\n\n")
}

func Verse(num int) string {
	verse := make([]string, 0, num)

	for i := num - 1; i >= 0; i-- {
		prefix := "This is"

		if i != num-1 {
			prefix = fmt.Sprintf("that %s", parts[i].action)
		}

		verse = append(verse, fmt.Sprintf("%s %s", prefix, parts[i].subject))
	}

	return strings.Join(verse, "\n")
}
