package stringset

import (
	"fmt"
	"strings"
)

type Set map[string]bool

func (s Set) String() string {
	parts := make([]string, 0, len(s))

	for val, _ := range s {
		parts = append(parts, fmt.Sprintf("%q", val))
	}

	return fmt.Sprintf("{%s}", strings.Join(parts, ", "))
}

func (s Set) IsEmpty() bool {
	return len(s) == 0
}

func (s Set) Has(val string) bool {
	if _, ok := s[val]; ok {
		return true
	}

	return false
}

func (s Set) Add(val string) {
	s[val] = true
}

func New() Set {
	return Set{}
}

func NewFromSlice(slice []string) Set {
	set := New()

	for _, val := range slice {
		set.Add(val)
	}

	return set
}

func Subset(s1, s2 Set) bool {
	return len(s1) == 0 || len(s1) == len(Intersection(s1, s2))
}

func Disjoint(s1, s2 Set) bool {
	return len(s1) == len(Difference(s1, s2))
}

func Equal(s1, s2 Set) bool {
	return len(s1) == len(s2) && len(Difference(s1, s2)) == 0
}

func Intersection(s1, s2 Set) Set {
	return mapSet(s1, s2, func(val string, s Set) bool {
		return s.Has(val)
	})
}

func Difference(s1, s2 Set) Set {
	return mapSet(s1, s2, func(val string, s Set) bool {
		return !s.Has(val)
	})
}

func Union(s1, s2 Set) Set {
	set := New()

	for val, _ := range s1 {
		set.Add(val)
	}

	for val, _ := range s2 {
		set.Add(val)
	}

	return set
}

func mapSet(s1 Set, s2 Set, fn func(string, Set) bool) Set {
	set := New()

	for val, _ := range s1 {
		if fn(val, s2) {
			set.Add(val)
		}
	}

	return set
}
