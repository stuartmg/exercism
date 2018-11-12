package school

import "sort"

type Grade struct {
	grade    int
	students []string
}

type School struct {
	grades map[int]*Grade
}

func (s *School) Add(student string, grade int) {
	if g, ok := s.grades[grade]; ok {
		g.students = append(g.students, student)
	} else {
		s.grades[grade] = &Grade{grade: grade, students: []string{student}}
	}
}

func (s *School) Grade(grade int) []string {
	if g, ok := s.grades[grade]; ok {
		sort.Strings(g.students)
		return g.students
	}

	return []string{}
}

func (s *School) Enrollment() []Grade {
	grades := make([]Grade, 0, len(s.grades))

	for _, g := range s.grades {
		sort.Strings(g.students)
		grades = append(grades, *g)
	}

	sort.Slice(grades, func(i, j int) bool { return grades[i].grade < grades[j].grade })
	return grades
}

func New() *School {
	return &School{grades: make(map[int]*Grade)}
}
