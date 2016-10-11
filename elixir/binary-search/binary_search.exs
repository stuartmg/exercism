defmodule BinarySearch do
  @doc """
    Searches for a key in the list using the binary search algorithm.
    It returns :not_found if the key is not in the list.
    Otherwise returns the tuple {:ok, index}.

    ## Examples

      iex> BinarySearch.search([], 2)
      :not_found

      iex> BinarySearch.search([1, 3, 5], 2)
      :not_found

      iex> BinarySearch.search([1, 3, 5], 5)
      {:ok, 2}

  """

  @spec search(Enumerable.t, integer) :: {:ok, integer} | :not_found
  def search(list, key) do
    if list != Enum.sort(list), do: raise ArgumentError, "expected list to be sorted"

    do_search(Enum.with_index(list), key)
  end

  defp do_search([], _key), do: :not_found
  defp do_search(list, key) do
    {head,[{check_val, check_index}|tail]} = Enum.split(list, halfway(list))

    cond do
      key < check_val -> do_search(head, key)
      key > check_val -> do_search(tail, key)
      true -> {:ok, check_index}
    end
  end

  defp halfway(list), do: list |> Enum.count |> div(2)
end
