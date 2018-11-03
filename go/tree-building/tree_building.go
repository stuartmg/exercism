package tree

import (
	"errors"
	"sort"
)

type Record struct {
	ID, Parent int
}

type Node struct {
	ID       int
	Children []*Node
}

type Mismatch struct{}

func (m Mismatch) Error() string {
	return "c"
}

func Build(records []Record) (*Node, error) {
	if len(records) == 0 {
		return nil, nil
	}

	// put records in order (we need parent records to exist before we process child records)
	sort.Slice(records, func(i, j int) bool {
		return records[i].Parent <= records[j].Parent && records[i].ID <= records[j].ID
	})

	var nodes = make(map[int]*Node)
	var root *Node

	for _, record := range records {
		var node = &Node{ID: record.ID}

		// check to see if this is a duplicate node
		if nodes[record.ID] != nil {
			return nil, errors.New("Duplicate node found")
		}

		if record.ID == 0 {
			// check if we already have a root node
			if root != nil {
				return nil, errors.New("Multiple root nodes found")
			}

			// make sure node's parent is also zero
			if record.Parent != 0 {
				return nil, errors.New("Invalid node found")
			}

			root = node
			nodes[0] = root
			continue
		}

		// make sure node id is less than parent id
		if record.ID <= record.Parent {
			return nil, errors.New("Invalid node found")
		}

		parent := nodes[record.Parent]
		if parent == nil {
			return nil, errors.New("Unknown parent node")
		}

		// add node to parent and resort the parent's children
		parent.Children = append(parent.Children, node)
		sort.Slice(parent.Children, func(i, j int) bool { return parent.Children[i].ID < parent.Children[j].ID })

		nodes[record.ID] = node
	}

	// make sure there are no gaps in IDs
	for i := 0; i < len(records); i++ {
		if nodes[i] == nil {
			return nil, errors.New("Gap found in IDs")
		}
	}

	return root, nil
}
