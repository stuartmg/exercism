defmodule BinTree do
  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{ value: any, left: BinTree.t | nil, right: BinTree.t | nil }
  defstruct value: nil, left: nil, right: nil
end

defmodule Zipper do
  @type trail :: { :left, any, BinTree.t, trail } | { :right, any, BinTree.t, trail } | :top
  defstruct focus: nil, root: nil, trail: []

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BT.t) :: Z.t
  def from_tree(bt) do
    IO.puts "******************** #{inspect(bt)}"
    %Zipper{focus: bt, root: bt}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t) :: BT.t
  def to_tree(%Zipper{root: root}) do
    IO.puts "******************** #{inspect(root)}"
    root
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t) :: any
  def value(%Zipper{focus: focus}), do: focus.value

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t) :: Z.t | nil
  def left(%Zipper{focus: %BinTree{left: nil}}), do: nil
  def left(z = %Zipper{focus: focus, trail: trail}) do
    IO.puts "******************** #{inspect(focus)}"
    %Zipper{z | focus: focus.left, trail: [:left | trail]}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t) :: Z.t | nil
  def right(%Zipper{focus: %BinTree{right: nil}}), do: nil
  def right(z = %Zipper{focus: focus, trail: trail}) do
    %Zipper{z | focus: focus.right, trail: [:right | trail]}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t) :: Z.t
  def up(%Zipper{focus: root, root: root, trail: []}), do: nil
  def up(z) do
    parent_trail = z.trail |> Enum.drop(1)
    parent_node = find_node(z.root, parent_trail |> Enum.reverse)

    %Zipper{focus: parent_node, root: z.root, trail: parent_trail}
  end

  defp find_node(focus, []), do: focus
  defp find_node(focus, [:left | trail]), do: find_node(focus.left, trail)
  defp find_node(focus, [:right | trail]), do: find_node(focus.right, trail)

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t, any) :: Z.t
  def set_value(z = %Zipper{focus: focus}, v) do
    # IO.puts "******************** #{inspect(z)}"
    y = Map.put(z, :focus, %BinTree{value: v, left: focus.left, right: focus.right})
    # IO.puts "******************** #{inspect(y)}"
    y
  end

  defp update_focus(z, new_focus) do
    %Zipper { z | focus: new_focus, root: rebuild_root(z.root, new_focus, z.trail |> Enum.reverse) }
  end

  defp rebuild_root(tree, subtree, []), do: subtree
  defp rebuild_root(tree, subtree, [:left | trail]), do: %BinTree{ tree | left: rebuild_root(tree.left, subtree, trail) }
  defp rebuild_root(tree, subtree, [:right | trail]), do: %BinTree{ tree | right: rebuild_root(tree.right, subtree, trail) }

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t, BT.t) :: Z.t
  def set_left(z, l) do
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t, BT.t) :: Z.t
  def set_right(z, r) do

  end

  # defp replace_node(z, tree) do

  # end

  # defp to_root(z), do: to_root(z, Map.get(z, :parent))
  # defp to_root(z, nil), do: z
  # defp to_root(z, parent), do: to_root(parent, Map.get(z, :parent))

  # defp current_tree(z), do: Map.get(z, :tree)

  # defp to_bt(nil), do: nil
  # defp to_bt(z) do
  #   IO.puts "************* TO_BT: #{inspect(z)}"
  #   %BinTree{value: z.value, left: to_bt(z.left), right: to_bt(z.right) }
  # end

  # defp to_z(node, parent \\ nil, direction \\ nil)
  # defp to_z(nil, _parent, _direction), do: nil
  # defp to_z(node, parent, direction) do
  #   z = %Zipper{ value: node.value, parent: parent, direction: direction }

  #   z
  #   |> Map.put(:left, to_z(node.left, z, :left))
  #   |> Map.put(:right, to_z(node.right, z, :right))
  # end

end
