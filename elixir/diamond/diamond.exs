defmodule Diamond do

  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(?A), do: "A\n"
  def build_shape(letter) do
    ?A..letter
    |> Enum.map(&(&1))
    |> build_top(0, [])
    |> build_diamond
    |> Enum.join("\n")
    |> Kernel.<>("\n")
  end

  defp build_top([], _spaces, acc), do: acc
  defp build_top([head|tail], spaces, acc) do
    row = build_row(head, spaces)
    build_top(tail, String.length(row), [ add_prefix(row, Enum.count(tail)) | acc])
  end

  defp build_diamond(top) do
    top
    |> Enum.reverse
    |> Kernel.++(top)
    |> Enum.dedup
  end

  defp build_row(letter, spaces) do
    letter
    |> List.duplicate(2)
    |> add_spacing(spaces)
    |> Enum.dedup
    |> to_string
  end

  defp add_spacing(row, 0), do: row
  defp add_spacing(row, spaces), do: row |> Enum.intersperse(List.duplicate(' ', spaces))

  defp add_prefix(str, spaces), do: String.duplicate(" ", spaces) <> str

end
