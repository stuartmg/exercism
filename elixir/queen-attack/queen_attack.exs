defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white \\ {0,3}, black \\ {7,3})
  def new(white, black) when white == black, do: raise ArgumentError
  def new(white, black) do
    %Queens{ white: white, black: black }
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    Enum.map_join(0..7, "\n", &row(&1, queens))
  end

  defp row(row_num, queens), do: Enum.map_join(0..7, " ", &cell(row_num, &1, queens))

  defp cell(row, col, %{black: {row,col}}), do: "B"
  defp cell(row, col, %{white: {row,col}}), do: "W"
  defp cell(_row, _col, _queens), do: "_"

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%{black: {row, _}, white: {row, _}}), do: true
  def can_attack?(%{black: {_, col}, white: {_, col}}), do: true
  def can_attack?(%{black: {black_row, black_col}, white: {white_row, white_col}}) do
    abs(black_row - white_row) == abs(black_col - white_col)
  end
end
