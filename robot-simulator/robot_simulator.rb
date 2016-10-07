class Robot

  DIRECTIONS = [:north, :east, :south, :west]

  def initialize
    at(0,0)
    orient(:north)
  end

  def at(x, y)
    @x = x
    @y = y
  end

  def orient(direction)
    raise ArgumentError, "Invalid direction" unless DIRECTIONS.include? direction

    @direction = direction
  end

  def bearing
    @direction
  end

  def coordinates
    [@x, @y]
  end

  def turn_right
    case @direction
    when :east then @direction = :south
    when :west then @direction = :north
    when :north then @direction = :east
    when :south then @direction = :west
    end
  end

  def turn_left
    case @direction
    when :east then @direction = :north
    when :west then @direction = :south
    when :north then @direction = :west
    when :south then @direction = :east
    end
  end

  def advance
    case @direction
    when :north then at(@x, @y+1)
    when :south then at(@x, @y-1)
    when :east then at(@x+1, @y)
    when :west then at(@x-1, @y)
    end
  end

end

class Simulator

  INSTRUCTIONS = {
    "L" => :turn_left,
    "R" => :turn_right,
    "A" => :advance
  }

  def instructions(input)
    input.chars.each_with_object([]) { |cmd, instructions| instructions << INSTRUCTIONS[cmd] }
  end

  def place(robot, options)
    robot.at(options[:x], options[:y])
    robot.orient(options[:direction])
  end

  def evaluate(robot, commands)
    instructions(commands).each { |cmd| robot.send(cmd) }
  end

end
