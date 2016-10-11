defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise ArgumentError
  def nth(count) do
    count
    |> do_nth(1, [])
    |> List.first
  end

  def do_nth(count, _num, acc) when length(acc) == count, do: acc
  def do_nth(count, num, acc) do
    case prime?(num) do
      true -> do_nth(count, num + 1, [num|acc])
      false -> do_nth(count, num + 1, acc)
    end
  end

  # primality test (see wikipedia)
  defp prime?(num) do
    cond do
      num <= 1 -> false
      num <= 3 -> true
      rem(num,2) == 0 -> false
      rem(num,3) == 0 -> false
      true -> prime?(num, 5)
    end
  end

  defp prime?(num, i) do
    cond do
      i*i > num -> true
      rem(num,i) == 0 -> false
      rem(num,i+2) == 0 -> false
      true -> prime?(num, i+6)
    end
  end

end