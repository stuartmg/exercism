package flatten

func Flatten(input interface{}) interface{} {
  if arr, ok := input.([]interface{}); ok {
    return flatten(arr)
  }

  return input
}

func flatten(input []interface{}) []interface{} {
  results := make([]interface{}, 0, len(input))

  for _, val := range input {
    if arr, ok := val.([]interface{}); ok {
      results = append(results, flatten(arr)...)
    } else if val != nil {
      results = append(results, val)
    }
  }

  return results
}
