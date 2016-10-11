defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a dict of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> Enum.join
    |> String.strip
    |> String.downcase
    |> String.replace(~r/[\W|_|\d]/u, "")
    |> String.graphemes
    |> chunk_work(workers)
    |> Enum.map(&Task.async(fn -> count_letters(&1) end))
    |> Enum.map(&Task.await/1)
    |> Enum.reduce(Map.new, &Map.merge(&1, &2, fn(_k,v1,v2) -> v1 + v2 end))
  end

  defp chunk_work(list, workers) do
    chunk_size = div(Enum.count(list), workers) + 1

    Enum.chunk(list, chunk_size, chunk_size, [])
  end

  defp count_letters(letters) do
    letters
    |> Enum.reduce(Map.new, fn(letter, map) -> Map.update(map, letter, 1, &(&1 + 1)) end)
  end
end
