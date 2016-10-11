defmodule Garden do

  @students ~w(Alice, Bob, Charlie, David, Eve, Fred, Ginny, Harriet, Ileana, Joseph, Kincaid, Larry)
  @plants %{
    "G" => :grass,
    "C" => :clover,
    "R" => :radishes,
    "V" => :violets
  }

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @students) do
    info_string
    |> String.split
    |> Enum.map(&String.split(&1, "", trim: true))
    |>
  end

end
