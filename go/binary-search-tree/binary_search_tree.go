package binarysearchtree

type SearchTreeData struct {
	left  *SearchTreeData
	data  int
	right *SearchTreeData
}

func Bst(data int) *SearchTreeData {
	return &SearchTreeData{data: data}
}

func (tree *SearchTreeData) Insert(data int) {
	switch {
	case data <= tree.data && tree.left == nil:
		tree.left = &SearchTreeData{data: data}
	case data > tree.data && tree.right == nil:
		tree.right = &SearchTreeData{data: data}
	case data <= tree.data:
		tree.left.Insert(data)
	case data > tree.data:
		tree.right.Insert(data)
	}
}

func (tree *SearchTreeData) MapString(fn func(int) string) []string {
	results := make([]string, 0, 10)

	if tree.left != nil {
		results = append(results, tree.left.MapString(fn)...)
	}

	results = append(results, fn(tree.data))

	if tree.right != nil {
		results = append(results, tree.right.MapString(fn)...)
	}

	return results
}

func (tree *SearchTreeData) MapInt(fn func(int) int) []int {
	results := make([]int, 0, 10)

	if tree.left != nil {
		results = append(results, tree.left.MapInt(fn)...)
	}

	results = append(results, fn(tree.data))

	if tree.right != nil {
		results = append(results, tree.right.MapInt(fn)...)
	}

	return results
}

func navigate(tree *SearchTreeData, target int) *SearchTreeData {
	if tree.data == target {
		return tree
	}

	if target < tree.data && tree.left != nil {
		return navigate(tree.left, target)
	}

	if target > tree.data && tree.right != nil {
		return navigate(tree.right, target)
	}

	return tree
}
