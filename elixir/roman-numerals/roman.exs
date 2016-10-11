defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number), do: do_numerals(number, "")

  defp do_numerals(0, acc), do: acc
  defp do_numerals(num, acc) when num >= 1000, do: do_numerals(num - 1000, acc <> "M")
  defp do_numerals(num, acc) when num >= 900,  do: do_numerals(num - 900, acc <> "CM")
  defp do_numerals(num, acc) when num >= 500,  do: do_numerals(num - 500, acc <> "D")
  defp do_numerals(num, acc) when num >= 400,  do: do_numerals(num - 400, acc <> "CD")
  defp do_numerals(num, acc) when num >= 100,  do: do_numerals(num - 100, acc <> "C")
  defp do_numerals(num, acc) when num >= 90,   do: do_numerals(num - 90, acc <> "XC")
  defp do_numerals(num, acc) when num >= 50,   do: do_numerals(num - 50, acc <> "L")
  defp do_numerals(num, acc) when num >= 40,   do: do_numerals(num - 40, acc <> "XL")
  defp do_numerals(num, acc) when num >= 10,   do: do_numerals(num - 10, acc <> "X")
  defp do_numerals(num, acc) when num >= 9,    do: do_numerals(num - 9, acc <> "IX")
  defp do_numerals(num, acc) when num >= 5,    do: do_numerals(num - 5, acc <> "V")
  defp do_numerals(num, acc) when num >= 4,    do: do_numerals(num - 4, acc <> "IV")
  defp do_numerals(num, acc), do: do_numerals(num - 1, acc <> "I")
end
