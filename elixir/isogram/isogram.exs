defmodule Isogram do

  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    sorted = sentence |> String.replace(~r/\W/u, "") |> String.graphemes |> Enum.sort
    deduped = sorted |> Enum.dedup

    sorted == deduped
  end

end
