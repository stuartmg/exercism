defmodule BracketPush do
  @brackets ["{", "}", "(", ")", "[", "]"]

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    do_check_brackets(String.graphemes(str), []) == []
  end

  defp do_check_brackets([head|tail], acc) do
    cond do
      matching_bracket?(List.first(acc), head) -> do_check_brackets(tail, List.delete_at(acc, 0))
      bracket?(head) -> do_check_brackets(tail, [head | acc])
      true -> do_check_brackets(tail, acc)
    end
  end
  defp do_check_brackets([], acc), do: acc

  defp bracket?(str), do: Enum.member?(@brackets, str)

  defp matching_bracket?("{", "}"), do: true
  defp matching_bracket?("(", ")"), do: true
  defp matching_bracket?("[", "]"), do: true
  defp matching_bracket?(_, _), do: false
end
