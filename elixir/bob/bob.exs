defmodule Bob do
  def hey(input) do
    cond do
      is_blank?(input) == "" -> "Fine. Be that way!"
      is_question?(input) -> "Sure."
      is_yelling?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp is_blank?(str) do
    String.strip(str)
  end

  defp is_question?(str) do
    String.ends_with?(str, "?")
  end

  defp is_yelling?(str) do
    str == String.upcase(str) and str != String.downcase(str)
  end
end
