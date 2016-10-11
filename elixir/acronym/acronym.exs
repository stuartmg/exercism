defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> words
    |> acronym
  end

  defp words(string) do
    string
    |> String.split(~r/\s|-|(?=[A-Z])/u, trim: true)
    |> Enum.map(&(String.upcase/1))
  end

  defp acronym(words) do
    Enum.reduce(words, "", fn(word, acc) -> acc <> String.first(word) end)
  end
end
