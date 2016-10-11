defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number
    |> String.graphemes
    |> Enum.map(&String.to_integer/1)
    |> Enum.reverse
    |> Enum.chunk(2, 2, [0])
    |> Enum.flat_map(&convert_nums/1)
    |> Enum.sum
  end

  defp convert_nums([a, b]) when 2*b > 9, do: [a, 2*b - 9]
  defp convert_nums([a, b]), do: [a, 2*b]

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number), do: rem(checksum(number), 10) == 0

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    case valid?(number) do
      true -> number
      false -> number <> Integer.to_string(check_digit(number))
    end
  end

  defp check_digit(number) do
    check_digit = 10 - rem(checksum("#{number}0"), 10)

    cond do
      check_digit == 10 -> 0
      true -> check_digit
    end
  end
end