defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns :error if it is not possible to compute the right amount of coins.
    Otherwise returns the tuple {:ok, map_of_coins}

    ## Examples

      iex> Change.generate(3, [5, 10, 15])
      :error

      iex> Change.generate(18, [1, 5, 10])
      {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """
  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(amount, []), do: :error
  def generate(amount, [head|_tail]) when amount < head, do: :error
  def generate(amount, values) do
    map_of_coins = values |> Enum.sort |> Enum.reverse |> do_generate(amount, %{})
    {:ok, map_of_coins}
  end

  defp do_generate([], _amount, acc), do: acc
  defp do_generate([head|tail], amount, acc) do
    { coins, remainder } = divrem(amount, head)
    do_generate(tail, remainder, Map.put(acc, head, coins))
  end

  defp divrem(left, right), do: { div(left,right), rem(left,right) }
end
