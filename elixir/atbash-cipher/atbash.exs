defmodule Atbash do

  @lookup_table Enum.zip(?a..?z, ?z..?a) |> Map.new

  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    plaintext
    |> String.downcase
    |> String.replace(~r/\W/, "")
    |> String.to_charlist
    |> Enum.map(&Map.get(@lookup_table, &1, &1))
    |> Enum.chunk(5,5,'')
    |> Enum.join(" ")
  end

end
