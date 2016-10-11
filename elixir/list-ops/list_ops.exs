defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([_head | tail]), do: 1 + count(tail)

  @spec reverse(list) :: list
  def reverse([]), do: []
  def reverse(list), do: do_reverse(list, [])

  defp do_reverse([], acc), do: acc
  defp do_reverse([head|tail], acc), do: do_reverse(tail, [head | acc])

  @spec map(list, (any -> any)) :: list
  def map([], _func), do: []
  def map([head | tail], func), do: [ func.(head) | map(tail, func) ]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], func), do: []
  def filter([head|tail], func) do
    case func.(head) do
      true -> [ head | filter(tail, func) ]
      false -> filter(tail, func)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _func), do: acc
  def reduce([head|tail], acc, func), do: reduce(tail, func.(head, acc), func)

  @spec append(list, list) :: list
  def append([], []), do: []
  def append([], [head|tail]), do: [head | append([], tail)]
  def append([head|tail], other), do: [head | append(tail, other)]

  @spec concat([[any]]) :: [any]
  def concat(lists) do
    reduce(lists, [], &(reduce(&1, &2, fn(item,acc) -> [item | acc] end)))
    |> reverse
  end
end
