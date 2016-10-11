defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  def encode(""), do: ""
  def encode(str) do
    str
    |> String.replace(~r/\W|_/, "")
    |> String.downcase
    |> do_encode
  end

  defp do_encode(str) do
    num_cols = row_length(str)

    str
    |> String.graphemes
    |> Enum.chunk(num_cols, num_cols, List.duplicate("", num_cols))
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.join(" ")
  end

  defp row_length(str) do
    str
    |> String.length
    |> :math.sqrt
    |> Float.ceil
    |> Kernel.trunc
  end

  # defp rows(str, num_cols) do
  # end

  # defp cols(rows, num_cols) do
  #   Enum.map_join(0..num_cols-1, " ", &col(rows, &1))
  # end

  # defp col(rows, col) do
  #   Enum.map_join(rows, &Enum.at(&1, col))
  #   |> String.strip
  # end
end
