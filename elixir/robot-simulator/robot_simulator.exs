defmodule RobotSimulator do

  defstruct direction: :north, position: {0,0}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: { integer, integer }) :: any
  def create(direction \\ :north, position \\ {0,0})

  def create(direction, _position) when not direction in [:north, :east, :south, :west] do
    {:error, "invalid direction"}
  end

  def create(_direction, position) when not is_tuple(position) do
    {:error, "invalid position"}
  end

  def create(_direction, position) when tuple_size(position) != 2 do
    {:error, "invalid position"}
  end

  def create(_direction, {a,b}) when not is_integer(a) or not is_integer(b) do
    {:error, "invalid position"}
  end

  def create(direction, position) do
    %RobotSimulator{direction: direction, position: position}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t ) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.graphemes
    |> do_simulate(robot)
  end

  defp do_simulate([], robot), do: robot

  defp do_simulate(["L"|tail], %RobotSimulator{direction: dir} = robot) do
    case dir do
      :north -> do_simulate(tail, Map.put(robot, :direction, :west))
      :west  -> do_simulate(tail, Map.put(robot, :direction, :south))
      :south -> do_simulate(tail, Map.put(robot, :direction, :east))
      :east  -> do_simulate(tail, Map.put(robot, :direction, :north))
    end
  end

  defp do_simulate(["R"|tail], %RobotSimulator{direction: dir} = robot) do
    case dir do
      :north -> do_simulate(tail, Map.put(robot, :direction, :east))
      :east  -> do_simulate(tail, Map.put(robot, :direction, :south))
      :south -> do_simulate(tail, Map.put(robot, :direction, :west))
      :west  -> do_simulate(tail, Map.put(robot, :direction, :north))
    end
  end

  defp do_simulate(["A"|tail], %RobotSimulator{direction: dir, position: {x,y}} = robot) do
    case dir do
      :north -> do_simulate(tail, Map.put(robot, :position, {x,y+1}))
      :east  -> do_simulate(tail, Map.put(robot, :position, {x+1,y}))
      :south -> do_simulate(tail, Map.put(robot, :position, {x,y-1}))
      :west  -> do_simulate(tail, Map.put(robot, :position, {x-1,y}))
    end
  end

  defp do_simulate(_instructions, _robot), do: {:error, "invalid instruction"}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec position(robot :: any) :: { integer, integer }
  def position(robot) do
    robot.position
  end

end
