defmodule Bowling do

  defstruct rolls: [], frame: [], frames: 0

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: any
  def start do
    %Bowling{}
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

  def roll(game = %{frame: []}, roll) when roll == 10 do
    %{ game | rolls: [10 | game.rolls], frames: game.frames+1 }
  end

  def roll(game = %{frame: []}, roll) do
    %{ game | rolls: [roll | game.rolls], frame: [roll] }
  end

  def roll(%{frame: [prev]}, roll) when prev+roll > 10 do
    {:error, "Pin count exceeds pins on the lane"}
  end

  def roll(game, roll) do
    %{ game | rolls: [roll | game.rolls], frame: [], frames: game.frames+1 }
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """

  @spec score(any) :: integer | String.t
  def score(%{rolls: rolls, frames: frames}) do
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
