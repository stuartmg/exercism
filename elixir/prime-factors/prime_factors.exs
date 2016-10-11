defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    do_factors_for(number, 2, [])
    |> Enum.reverse
  end

  defp do_factors_for(1, _div, acc), do: acc
  defp do_factors_for(num, div, acc) when rem(num, div) == 0 do
    do_factors_for(div(num, div), div, [div | acc])
  end
  defp do_factors_for(num, div, acc) do
    do_factors_for(num, div + 1, acc)
  end
end
