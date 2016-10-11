defmodule Allergies do
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    do_list(flags, [])
  end

  defp do_list(n, acc) when n >= 128, do: do_list(n - 128, ["cats" | acc])
  defp do_list(n, acc) when n >= 64,  do: do_list(n - 64, ["pollen" | acc])
  defp do_list(n, acc) when n >= 32,  do: do_list(n - 32, ["chocolate" | acc])
  defp do_list(n, acc) when n >= 16,  do: do_list(n - 16, ["tomatoes" | acc])
  defp do_list(n, acc) when n >= 8,   do: do_list(n - 8, ["strawberries" | acc])
  defp do_list(n, acc) when n >= 4,   do: do_list(n - 4, ["shellfish" | acc])
  defp do_list(n, acc) when n >= 2,   do: do_list(n - 2, ["peanuts" | acc])
  defp do_list(n, acc) when n >= 1,   do: do_list(n - 1, ["eggs" | acc])
  defp do_list(_n, acc), do: acc

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    item in list(flags)
  end
end
