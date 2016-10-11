defmodule Raindrops do

  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    { number, "" }
    |> do_convert(3, "Pling")
    |> do_convert(5, "Plang")
    |> do_convert(7, "Plong")
    |> speak
  end

  defp do_convert({num,acc}, fac, noise) when rem(num,fac) == 0 do
    {num, acc <> noise}
  end
  defp do_convert(tuple, _fac, _noise), do: tuple

  defp speak({num, ""}), do: Integer.to_string(num)
  defp speak({_num, acc}), do: acc

end
