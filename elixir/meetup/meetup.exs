defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, :first), do: do_meetup(year, month, weekday, 1)
  def meetup(year, month, weekday, :second), do: do_meetup(year, month, weekday, 8)
  def meetup(year, month, weekday, :third), do: do_meetup(year, month, weekday, 15)
  def meetup(year, month, weekday, :fourth), do: do_meetup(year, month, weekday, 22)
  def meetup(year, month, weekday, :teenth), do: do_meetup(year, month, weekday, 13)
  def meetup(year, month, weekday, :last), do: do_meetup(year, month, weekday, start_of_last_week(year, month))

  defp start_of_last_week(year, month), do: :calendar.last_day_of_the_month(year, month) - 6

  defp do_meetup(year, month, :monday, offset), do: do_meetup(year, month, 1, offset)
  defp do_meetup(year, month, :tuesday, offset), do: do_meetup(year, month, 2, offset)
  defp do_meetup(year, month, :wednesday, offset), do: do_meetup(year, month, 3, offset)
  defp do_meetup(year, month, :thursday, offset), do: do_meetup(year, month, 4, offset)
  defp do_meetup(year, month, :friday, offset), do: do_meetup(year, month, 5, offset)
  defp do_meetup(year, month, :saturday, offset), do: do_meetup(year, month, 6, offset)
  defp do_meetup(year, month, :sunday, offset), do: do_meetup(year, month, 7, offset)

  defp do_meetup(year, month, daynum, offset) do
    day = daynum - :calendar.day_of_the_week(year, month, offset) + offset

    cond do
      day < offset -> {year, month, day + 7}
      true -> {year, month, day}
    end
  end
end
