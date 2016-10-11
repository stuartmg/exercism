defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num), do: do_rows(num, 0, []) |> Enum.reverse

  defp do_rows(rows, rows, acc), do: acc
  defp do_rows(rows, cur, acc), do: do_rows( rows, cur+1, [ row(List.first(acc)) | acc ] )

  defp row(nil), do: [1]
  defp row(prev_row) do
    prev_row
    |> Enum.chunk(2, 1)
    |> Enum.map(fn [a,b] -> a + b end)
    |> List.insert_at(0, 1)
    |> List.insert_at(-1, 1)
  end
end
