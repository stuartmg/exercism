package letter

import "sync"

type FreqMap map[rune]int

func Frequency(s string) FreqMap {
	m := FreqMap{}
	for _, r := range s {
		m[r]++
	}
	return m
}

func ConcurrentFrequency(list []string) FreqMap {
	var wg sync.WaitGroup
	ch := make(chan FreqMap)

	for _, s := range list {
		wg.Add(1)
		go func(s string) {
			defer wg.Done()
			ch <- Frequency(s)
		}(s)
	}

	go func() {
		wg.Wait()
		close(ch)
	}()

	results := FreqMap{}
	for result := range ch {
		for key, val := range result {
			results[key] += val
		}
	}

	return results
}
