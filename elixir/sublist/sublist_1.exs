defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare([], []), do: :equal
  def compare([], _b), do: :sublist
  def compare(_a, []), do: :superlist
  def compare(a, b) when a == b, do: :equal

  def compare(a, b) when length(a) < length(b) do
    do_sublist(a, b, :sublist)
  end

  def compare(a, b) when length(a) > length(b) do
    do_sublist(b, a, :superlist)
  end

  def compare(a, b) when a != b, do: :unequal

  defp do_sublist(a, b, _type) when length(a) > length(b), do: :unequal

  defp do_sublist(a, b = [_head|tail], type) do
    lists = Enum.zip(a, b) |> Enum.unzip

    cond do
      elem(lists, 0) === elem(lists, 1) -> type
      true -> do_sublist(a, tail, type)
    end
  end

  defp do_sublist(_a, [], _type), do: :unequal
end
