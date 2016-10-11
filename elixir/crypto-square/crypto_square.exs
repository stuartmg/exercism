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
end
