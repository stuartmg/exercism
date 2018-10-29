package prime

func Nth(n int) (int, bool) {
	if n == 0 {
		return 0, false
	}

	primes := []int{}
	for i := 2; len(primes) < n; i++ {
		if isPrime(primes, i) {
			primes = append(primes, i)
		}
	}
	return primes[len(primes)-1], true
}

func isPrime(primes []int, num int) bool {
	for _, prime := range primes {
		if num%prime == 0 {
			return false
		}
	}
	return true
}
