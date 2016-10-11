defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    palindromes(min_factor, max_factor)
    |> Enum.group_by(fn([a,b]) -> a*b end)
  end

  defp palindromes(min, max) do
    for a <- min..max, b <- a..max, palindrome?(a*b), do: [a,b]
  end

  defp palindrome?(num) do
    n = Integer.to_string(num)
    n == String.reverse(n)
  end

end
