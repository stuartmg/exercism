package sieve

func Sieve(limit int) []int {
	sieve := make([]bool, limit+1)
	primes := make([]int, 0, limit)

	for i := 2; i <= limit; i++ {
		if sieve[i] {
			continue
		}

		for j := i * 2; j <= limit; j += i {
			sieve[j] = true
		}

		primes = append(primes, i)
	}

	return primes
}
