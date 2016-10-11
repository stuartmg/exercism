defmodule Forth do

  @opaque evaluator :: %Forth{ stack: List, funcs: Map }
  defstruct stack: [], funcs: Map.new

  defmodule Core do

    def funcs do
      Map.new([
        { "+", &plus/1 },
        { "-", &minus/1 },
        { "*", &times/1 },
        { "/", &divide/1 },
        { "DUP", &dup/1 },
        { "DROP", &drop/1 },
        { "SWAP", &swap/1 },
        { "OVER", &over/1 }
      ])
    end

    defp plus(stack), do: calculate(stack, &Kernel.+/2)
    defp minus(stack), do: calculate(stack, &Kernel.-/2)
    defp times(stack), do: calculate(stack, &Kernel.*/2)
    defp divide(stack), do: calculate(stack, &Kernel.//2)

    defp calculate(stack, func) do
      { args, rest } = Enum.split(stack, 2)

      try do
        [ trunc( apply(func, Enum.reverse(args)) ) | rest]
      rescue
        ArithmeticError -> raise Forth.DivisionByZero
      end
    end

    defp dup([]), do: raise Forth.StackUnderflow
    defp dup(stack), do: Enum.take(stack, 1) ++ stack

    defp drop([]), do: raise Forth.StackUnderflow
    defp drop(stack), do: List.delete_at(stack, 0)

    defp swap(stack) when length(stack) < 2, do: raise Forth.StackUnderflow
    defp swap(stack) do
      { [b,a], rest } = Enum.split(stack,2)
      [a, b] ++ rest
    end

    defp over(stack) when length(stack) < 2, do: raise Forth.StackUnderflow
    defp over(stack) do
      [_b,a] = Enum.take(stack, 2)
      [a | stack]
    end

  end

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new() do
    %Forth{ stack: [], funcs: Core.funcs }
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t) :: evaluator
  def eval(ev, s) do
    s
    |> tokenize
    |> do_eval(ev)
  end

  defp do_eval([], ev), do: ev

  defp do_eval([":",head | tail], ev = %Forth{funcs: funcs}) do
    if is_integer(head), do: raise Forth.InvalidWord, word: head

    { impl, [";" | rest] } = Enum.split_while(tail, fn(val) -> val != ";" end)
    new_funcs = Map.put(funcs, head, impl)

    do_eval(rest, Map.put(ev, :funcs, new_funcs))
  end

  defp do_eval([head|tail], ev = %Forth{stack: stack}) when is_integer(head) do
    do_eval(tail, Map.put(ev, :stack, [head | stack]))
  end

  defp do_eval([head|tail], ev = %Forth{stack: stack, funcs: funcs}) do
    case Map.get(funcs, head) do
      nil -> raise Forth.UnknownWord, word: head
      f when is_list(f) -> do_eval(f ++ tail, ev)
      f -> do_eval(tail, Map.put(ev, :stack, f.(stack)))
    end
  end

  defp tokenize(str) do
    str
    |> String.upcase
    |> String.split(~r/[^^\p{L}|\p{M}e|\p{N}|\p{S}|\p{P}]/u, trim: true)
    |> Enum.map(&convert_token/1)
  end

  defp convert_token(str) do
    case Integer.parse(str) do
      { i, "" } -> i
      _ -> str
    end
  end

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t
  def format_stack(ev) do
    ev
    |> Map.get(:stack)
    |> Enum.reverse
    |> Enum.join(" ")
  end

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception [word: nil]
    def message(e), do: "invalid word: #{inspect e.word}"
  end

  defmodule UnknownWord do
    defexception [word: nil]
    def message(e), do: "unknown word: #{inspect e.word}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
