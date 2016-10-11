defmodule Matrix do

  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(&parse_row/1)
  end

  defp parse_row(str) do
    str
    |> String.split
    |> Enum.map(&String.to_integer/1)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
    |> rows
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    cols = smallest_in_columns(str)
    rows = largest_in_rows(str)

    Enum.filter(rows, fn(row) -> row in cols end)
  end

  defp largest_in_rows(str) do
    str
    |> rows
    |> Enum.with_index
    |> Enum.reduce([], fn({row,idx}, acc) -> acc ++ largest_in_row(row, idx) end)
  end

  defp largest_in_row(row, row_num) do
    largest = row |> Enum.max
    row
    |> Enum.with_index
    |> Enum.filter_map(fn({val,_}) -> val == largest end, fn({_,col}) -> {row_num,col} end)
  end

  defp smallest_in_columns(str) do
    str
    |> columns
    |> Enum.with_index
    |> Enum.reduce([], fn({col,idx}, acc) -> acc ++ smallest_in_column(col,idx) end)
  end

  defp smallest_in_column(col, col_num) do
    smallest = col |> Enum.min
    col
    |> Enum.with_index
    |> Enum.filter_map(fn({val,_}) -> val == smallest end, fn({_,row}) -> {row,col_num} end)
  end

end
