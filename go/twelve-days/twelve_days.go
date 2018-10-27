package twelve

import (
  "fmt"
  "strings"
)

var days [][]string = [][]string{
  []string{"first", "a Partridge in a Pear Tree"},
  []string{"second", "two Turtle Doves"},
  []string{"third", "three French Hens"},
  []string{"fourth", "four Calling Birds"},
  []string{"fifth", "five Gold Rings"},
  []string{"sixth", "six Geese-a-Laying"},
  []string{"seventh", "seven Swans-a-Swimming"},
  []string{"eighth", "eight Maids-a-Milking"},
  []string{"ninth", "nine Ladies Dancing"},
  []string{"tenth", "ten Lords-a-Leaping"},
  []string{"eleventh", "eleven Pipers Piping"},
  []string{"twelfth", "twelve Drummers Drumming"},
}

func Song() string {
  parts := make([]string, 0, 12)

  for i := 1; i <= 12; i++ {
    parts = append(parts, Verse(i))
  }

  return strings.Join(parts, "\n") + "\n"
}

func Verse(verse int) string {
  return fmt.Sprintf("On the %s day of Christmas my true love gave to me, %s.", days[verse-1][0], giftPhrase(verse))
}

func giftPhrase(verse int) string {
  parts := make([]string, 0, verse)

  for i := verse - 1; i >= 0; i-- {
    if i == 0 && verse > 1 {
      parts = append(parts, "and "+days[i][1])
    } else {
      parts = append(parts, days[i][1])
    }
  }

  return strings.Join(parts, ", ")
}
