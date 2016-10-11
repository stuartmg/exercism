defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]
  @histogram %{?A => 0, ?C => 0, ?G => 0, ?T => 0}

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    cond do
      nucleotides?([nucleotide]) -> Map.get(histogram(strand), nucleotide, 0)
      true -> raise ArgumentError
    end
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    cond do
      nucleotides?(strand) -> Map.merge(@histogram, nucleotide_counts(strand))
      true -> raise ArgumentError
    end
  end

  defp nucleotides?(strand), do: Enum.all?(strand, &(Enum.member?(@nucleotides, &1)))

  defp nucleotide_counts(strand) do
    strand
    |> Enum.group_by(&(&1))
    |> Enum.reduce(%{}, fn({key,val}, acc) -> Map.put(acc, key, length(val)) end)
  end
end
