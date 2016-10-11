defmodule Bowling do

  defstruct rolls: [], frame: [], frames: 0

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: any
  def start do
    {:ok, pid} = Agent.start_link(fn -> %Bowling{} end)
    pid
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `:ok`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """

  @spec roll(any, integer) :: any | String.t
  def roll(_game, roll) when (roll < 0) or (roll > 10) do
    {:error, "Pins must have a value from 0 to 10"}
  end

  def roll(game, roll) do
    frame = Agent.get(game, fn(map) -> Map.get(map, :frame) end)
    do_roll(game, frame, roll)
  end

  defp do_roll(game, [], roll) when roll == 10 do
    Agent.update(game, fn(map) -> %{ map | rolls: [10 | map.rolls], frames: map.frames+1 } end)
    game
  end

  defp do_roll(game, [], roll) do
    Agent.update(game, fn(map) -> %{ map | rolls: [roll | map.rolls], frame: [roll] } end)
    game
  end

  defp do_roll(_game, [prev], roll) when prev+roll > 10 do
    {:error, "Pin count exceeds pins on the lane"}
  end

  defp do_roll(game, _frame, roll) do
    Agent.update(game, fn(map) -> %{ map | rolls: [roll | map.rolls], frame: [], frames: map.frames+1 } end)
    game
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """

  @spec score(any) :: integer | String.t
  def score(game) do
    %{ rolls: rolls, frames: frames } = Agent.get(game, &(&1))

    cond do
      frames < 10 -> {:error, "Score cannot be taken until the end of the game"}
      true -> rolls |> Enum.reverse |> do_score(1,0)
    end
  end

  defp do_score([], _frame, score), do: score
  defp do_score(_rolls, 11, score), do: score

  defp do_score([10|tail], frame, score) do
    [r2,r3] = Enum.take(tail, 2)
    do_score(tail, frame+1, score+10+r2+r3)
  end

  defp do_score([r1, r2|tail], frame, score) when r1+r2 == 10 do
    [r3] = Enum.take(tail, 1)
    do_score(tail, frame+1, score + 10 + r3)
  end

  defp do_score([r1, r2|tail], frame, score) do
    do_score(tail, frame+1, score+r1+r2)
  end

end
