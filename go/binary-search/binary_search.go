package binarysearch

func SearchInts(slice []int, key int) int {
	return search(slice, key, 0)
}

func search(slice []int, key int, base int) int {
	if len(slice) == 0 {
		return -1
	}

	mid := len(slice) / 2

	if slice[mid] == key {
		return base + mid
	}

	if key < slice[mid] {
		return search(slice[:mid], key, base)
	}

	return search(slice[mid+1:], key, base+mid+1)
}
