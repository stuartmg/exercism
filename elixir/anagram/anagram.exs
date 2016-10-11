defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    Enum.filter(candidates, &anagram?(String.downcase(base), String.downcase(&1)))
  end

  defp anagram?(base, base), do: false
  defp anagram?(base, candidate), do: do_sort(base) == do_sort(candidate)

  defp do_sort(candidate), do: String.graphemes(candidate) |> Enum.sort
end
