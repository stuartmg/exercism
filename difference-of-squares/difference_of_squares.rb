module BookKeeping
  VERSION = 3
end

class Squares

  def initialize(number)
    @range = (0..number)
  end

  def square_of_sum
    @range.reduce(:+) ** 2
  end

  def sum_of_squares
    @range.reduce {|sum, n| sum + (n ** 2) }
  end

  def difference
    square_of_sum - sum_of_squares
  end

end