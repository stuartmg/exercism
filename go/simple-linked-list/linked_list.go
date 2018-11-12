package linkedlist

import "errors"

type Element struct {
	data int
	next *Element
}

type List struct {
	head *Element
	size int
}

func (l *List) Size() int {
	return l.size
}

func (l *List) Push(data int) {
	node := &Element{data: data, next: l.head}

	l.head = node
	l.size++
}

func (l *List) Pop() (int, error) {
	if l.size == 0 {
		return -1, errors.New("List is empty")
	}

	data := l.head.data
	l.head = l.head.next
	l.size--

	return data, nil
}

func (l *List) Array() []int {
	values := make([]int, 0, l.size)

	for n := l.head; n != nil; n = n.next {
		values = append([]int{n.data}, values...)
	}

	return values
}

func (l *List) Reverse() *List {
	reversed := &List{}

	for n := l.head; n != nil; n = n.next {
		reversed.Push(n.data)
	}

	return reversed
}

func New(items []int) *List {
	list := &List{}

	for _, item := range items {
		list.Push(item)
	}

	return list
}
