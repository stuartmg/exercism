defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(list, (any -> any)) :: list
  def accumulate(list, fun) do
    do_accumulate(list, [], fun) |> reverse
  end

  defp do_accumulate([head|tail], acc, func), do: do_accumulate(tail, [func.(head) | acc], func)
  defp do_accumulate([], acc, _func), do: acc

  def reverse(list), do: do_reverse(list, [])

  defp do_reverse([head|tail], acc), do: do_reverse(tail, [head | acc])
  defp do_reverse([], acc), do: acc
end
