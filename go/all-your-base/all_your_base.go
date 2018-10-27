// allyourbase provides functionality to translate a number between 2 different bases
package allyourbase

import (
  "errors"
  "math"
)

// convert input from a base to another base
func ConvertToBase(from int, input []int, to int) ([]int, error) {
  if from < 2 {
    return nil, errors.New("input base must be >= 2")
  }
  if to < 2 {
    return nil, errors.New("output base must be >= 2")
  }

  num, err := fromBase(from, input)
  if err != nil {
    return nil, err
  }

  return toBase(to, num)
}

// convert input from a base into a base 10 int
func fromBase(base int, input []int) (int, error) {
  sum := 0

  for idx, num := range input {
    if num < 0 || num >= base {
      return 0, errors.New("all digits must satisfy 0 <= d < input base")
    }

    pow := len(input) - 1 - idx
    sum += num * int(math.Pow(float64(base), float64(pow)))
  }

  return sum, nil
}

// convert a base 10 int into an array of digits in the specific base
func toBase(base int, num int) ([]int, error) {
  output := []int{}
  for i := num; i > 0; {
    output = append([]int{i % base}, output...)
    i = i / base
  }

  if len(output) == 0 {
    output = append(output, 0)
  }

  return output, nil
}
