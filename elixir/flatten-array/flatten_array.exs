defmodule Flattener do

  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> Flattener.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> Flattener.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    do_flatten(list)
  end

  defp do_flatten([]), do: []

  defp do_flatten([head|tail]) do
    do_flatten(head) ++ do_flatten(tail)
  end

  defp do_flatten(nil), do: []

  defp do_flatten(head), do: [head]

end
