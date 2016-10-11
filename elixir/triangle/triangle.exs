defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) do
    cond do
      a <= 0 -> { :error, "all side lengths must be positive" }
      b <= 0 -> { :error, "all side lengths must be positive" }
      c <= 0 -> { :error, "all side lengths must be positive" }
      a + b <= c -> {:error, "side lengths violate triangle inequality"}
      a + c <= b -> {:error, "side lengths violate triangle inequality"}
      b + c <= a -> {:error, "side lengths violate triangle inequality"}
      true -> do_kind(a,b,c)
    end
  end

  defp do_kind(a, a, a), do: {:ok, :equilateral}
  defp do_kind(a, a, _), do: {:ok, :isosceles}
  defp do_kind(_, a, a), do: {:ok, :isosceles}
  defp do_kind(a, _, a), do: {:ok, :isosceles}
  defp do_kind(_, _, _), do: {:ok, :scalene}
end
