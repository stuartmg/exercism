defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    cond do
      hex?(hex) -> convert(hex)
      true -> 0
    end
  end

  defp hex?(str), do: Regex.match?(~r/^[0-9a-fA-F]*$/, str)

  defp convert(hex) do
    hex
    |> String.downcase
    |> String.reverse
    |> String.graphemes
    |> do_convert(1, 0)
  end

  defp do_convert([], _multiplier, acc), do: acc
  defp do_convert([head|tail], multiplier, acc) do
    do_convert(tail, multiplier * 16, (multiplier * hex_to_decimal(head)) + acc)
  end

  defp hex_to_decimal("a"), do: 10
  defp hex_to_decimal("b"), do: 11
  defp hex_to_decimal("c"), do: 12
  defp hex_to_decimal("d"), do: 13
  defp hex_to_decimal("e"), do: 14
  defp hex_to_decimal("f"), do: 15
  defp hex_to_decimal(str), do: String.to_integer(str)
end
