defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    case String.match?(string, ~r/^[0-1]*$/) do
      true -> convert(string)
      false -> 0
    end
  end

  defp convert(string) do
    string
    |> String.reverse
    |> String.graphemes
    |> Enum.with_index
    |> Enum.reduce(0, fn(elem, acc) -> acc + value(elem) end)
  end

  defp value({val, index}) do
    String.to_integer(val) * trunc(:math.pow(2, index))
  end
end
