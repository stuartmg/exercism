defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t
  def verse(number) do
    """
    #{String.capitalize(start_with(number))} of beer on the wall, #{start_with(number)} of beer.
    #{action(number)}, #{end_with(number)} of beer on the wall.
    """
  end

  defp start_with(1), do: "no more bottles"
  defp start_with(2), do: "1 bottle"
  defp start_with(number), do: "#{number - 1} bottles"

  defp action(1), do: "Go to the store and buy some more"
  defp action(2), do: "Take it down and pass it around"
  defp action(_number), do: "Take one down and pass it around"

  defp end_with(1), do: "99 bottles"
  defp end_with(2), do: "no more bottles"
  defp end_with(3), do: "1 bottle"
  defp end_with(number), do: "#{number - 2} bottles"

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics(range \\ 100..1) do
    Enum.map_join(range, "\n", &verse(&1))
  end
end
