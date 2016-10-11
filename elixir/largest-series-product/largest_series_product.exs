defmodule Series do

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
    cond do
      size == 0 -> 1
      size < 0 -> raise ArgumentError
      size > String.length(number_string) -> raise ArgumentError
      true -> do_largest_product(number_string, size)
    end
  end

  defp do_largest_product(number_string, size) do
    number_string
    |> String.graphemes
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk(size, 1)
    |> Enum.map(fn(chunk) -> product_of(chunk) end)
    |> Enum.max
  end

  defp product_of(list), do: Enum.reduce(list, 1, &(&1 * &2))

end