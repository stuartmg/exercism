package linkedlist

import (
	"errors"
	"fmt"
)

var ErrEmptyList error = errors.New("List is empty")

type Node struct {
	Val  interface{}
	prev *Node
	next *Node
}

func (n *Node) Next() *Node {
	return n.next
}

func (n *Node) Prev() *Node {
	return n.prev
}

func (n *Node) String() string {
	return fmt.Sprintf("[Prev() = %p, Val = %p (%v), Next() = %p]", n.Prev(), n, n.Val, n.Next())
}

type List struct {
	head *Node
	tail *Node
}

func (l *List) First() *Node {
	return l.head
}

func (l *List) Last() *Node {
	return l.tail
}

func (l *List) PushFront(item interface{}) {
	node := &Node{Val: item}
	head := l.head

	if head == nil {
		l.head = node
		l.tail = node
	} else {
		node.next = head
		head.prev = node
		l.head = node
	}
}

func (l *List) PushBack(item interface{}) {
	node := &Node{Val: item}
	tail := l.tail

	if tail == nil {
		l.tail = node
		l.head = node
	} else {
		node.prev = tail
		tail.next = node
		l.tail = node
	}
}

func (l *List) PopFront() (interface{}, error) {
	node := l.head

	if node == nil {
		return 0, ErrEmptyList
	}

	l.head = node.next

	if l.head == nil {
		l.tail = nil
	} else {
		l.head.prev = nil
	}

	return node.Val, nil
}

func (l *List) PopBack() (interface{}, error) {
	node := l.tail

	if node == nil {
		return 0, ErrEmptyList
	}

	l.tail = node.prev

	if l.tail == nil {
		l.head = nil
	} else {
		l.tail.next = nil
	}

	return node.Val, nil
}

func (l *List) Reverse() {
	dup := &List{}

	for l.head != nil {
		val, err := l.PopFront()
		if err == nil {
			dup.PushFront(val)
		}
	}

	l.head = dup.head
	l.tail = dup.tail

	return
}

func NewList(items ...interface{}) *List {
	list := &List{}

	for _, item := range items {
		list.PushBack(item)
	}

	return list
}
