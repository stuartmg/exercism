defmodule Minesweeper do

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]

  def annotate([]), do: []
  def annotate(board) do
    0..num_rows(board)
    |> Enum.map(&row(board, &1))
  end

  defp row(board, row) do
    Enum.reduce(0..num_cols(board), "", fn(col,acc) -> acc <> cell(board, row, col) end)
  end

  defp cell(board, row, col) do
    cond do
      mine?(board, row, col) -> "*"
      (c = count(board, row, col)) > 0 -> "#{c}"
      true -> " "
    end
  end

  defp count(board, row, col) do
    neighbors(board, row, col)
    |> Enum.reject(fn([r,c]) -> (r==row) and (c==col) end)
    |> Enum.map(fn([r,c]) -> mine?(board, r, c) end)
    |> Enum.count(fn(val) -> val == true end)
  end

  defp neighbors(board, row, col) do
    min_row = max(row-1, 0)
    max_row = min(row+1, num_rows(board))
    min_col = max(col-1, 0)
    max_col = min(col+1, num_cols(board))

    for r <- min_row..max_row, c <- min_col..max_col, do: [r,c]
  end

  defp mine?(board, row, col) do
    "*" == value(board,row,col)
  end

  defp value(board, row, col) do
    board
    |> Enum.fetch!(row)
    |> String.graphemes
    |> Enum.fetch!(col)
  end

  defp num_rows(board) do
    board |> Enum.count |> Kernel.-(1) |> max(0)
  end

  defp num_cols(board) do
    board
    |> Enum.at(0)
    |> String.length
    |> Kernel.-(1)
  end

end
