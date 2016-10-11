defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase
    |> String.to_charlist
    |> Enum.reduce(0, &(letter_value(&1) + &2))
  end

  defp letter_value(letter) when letter in 'AEIOULNRST', do: 1
  defp letter_value(letter) when letter in 'DG', do: 2
  defp letter_value(letter) when letter in 'BCMP', do: 3
  defp letter_value(letter) when letter in 'FHVWY', do: 4
  defp letter_value(letter) when letter in 'K', do: 5
  defp letter_value(letter) when letter in 'JX', do: 8
  defp letter_value(letter) when letter in 'QZ', do: 10
  defp letter_value(_letter), do: 0
end
