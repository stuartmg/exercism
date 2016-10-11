defmodule CustomSet do

  defstruct list: []

  def new(list \\ []) do
    set = list |> Enum.uniq |> Enum.sort
    %CustomSet{ list: set }
  end

  def delete(set, val) do
    new Enum.reject(set.list, &(&1 === val))
  end

  def difference(set, other) do
    new Enum.reject(set.list, &(Enum.member?(other.list, &1)))
  end

  def disjoint?(set, other) do
    set |> difference(other) |> equal?(set)
  end

  def empty(_list), do: new

  def equal?(set, other), do: set.list == other.list

  def intersection(set, other) do
    new Enum.filter(set.list, &(Enum.member?(other.list, &1)))
  end

  def member?(set, val) do
    Enum.member?(set.list, val)
  end

  def put(set, val), do: new [val | set.list ]

  def size(set), do: set |> to_list |> length

  def subset?(set, other) do
    Enum.all?(set.list, &(Enum.member?(other.list, &1)))
  end

  def to_list(set), do: Map.get(set, :list)

  def union(set, other) do
    new to_list(set) ++ to_list(other)
  end

end
