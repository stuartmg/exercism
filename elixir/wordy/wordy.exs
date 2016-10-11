defmodule Wordy do

  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer(question) do
    question
    |> String.replace(~r/\?/, "")
    |> String.split(" ")
    |> do_answer(0)
  end

  defp do_answer([], result), do: result

  defp do_answer(["What", "is" | tail], result) do
    do_answer(tail, result)
  end

  defp do_answer(["plus", num | tail], result) do
    do_answer(tail, result + String.to_integer(num))
  end

  defp do_answer(["minus", num | tail], result) do
    do_answer(tail, result - String.to_integer(num))
  end

  defp do_answer(["multiplied", "by", num | tail], result) do
    do_answer(tail, result * String.to_integer(num))
  end

  defp do_answer(["divided", "by", num | tail], result) do
    do_answer(tail, div(result, String.to_integer(num)))
  end

  defp do_answer(["raised", "to", "the", num, "power" | tail], result) do
    {pow, _} = Integer.parse(num)

    do_answer(tail, :math.pow(result, pow))
  end

  defp do_answer([head | tail], result) do
    case Integer.parse(head) do
      :error -> raise ArgumentError
      {num, _} -> do_answer(tail, num)
    end
  end

end
