defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> get_words
    |> count_words
  end

  defp count_words(words) do
    Enum.reduce(words, %{}, fn(word, acc) -> Map.update(acc, word, 1, &(&1 + 1)) end)
  end

  defp get_words(sentence) do
    sentence
    |> remove_punctuation()
    |> String.downcase()
    |> String.split()
  end

  defp remove_punctuation(sentence) do
    Regex.replace(~r/[^[:alnum:]\-]/u, sentence, " ")
  end
end
