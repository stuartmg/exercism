package diffsquares

// Returns the square of the sum of the first num natural number
func SquareOfSum(num int) int {
	sum := 0
	for i := num; i > 0; i-- {
		sum += i
	}
	return sum * sum
}

// Returns the sum of the squares of the first num natural numbers
func SumOfSquares(num int) int {
	sum := 0
	for i := num; i > 0; i-- {
		sum += i * i
	}
	return sum
}

// Returns the difference between the SquareOfSum and SumOfSquares
func Difference(num int) int {
	return SquareOfSum(num) - SumOfSquares(num)
}
