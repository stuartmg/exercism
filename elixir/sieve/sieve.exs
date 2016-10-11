defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    2..limit
    |> Enum.map(&(&1))
    |> do_primes(2, limit)
  end

  defp do_primes(list, limit, limit), do: list
  defp do_primes(list, counter, limit) do
    list
    |> Enum.filter(&multiple?(&1, counter))
    |> do_primes(counter + 1, limit)
  end

  defp multiple?(num, num), do: true
  defp multiple?(num, counter), do: rem(num,counter) != 0

end
