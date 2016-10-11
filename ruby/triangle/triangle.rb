class Triangle

  attr_reader :sides

  def initialize(a, b, c)
    @sides = [a,b,c]
  end

  def kind
    raise TriangleError if invalid?

    case sides.uniq.length
      when 1 then :equilateral
      when 2 then :isosceles
      when 3 then :scalene
    end
  end

  private

  def invalid?
    sum = sides.reduce(0) { |sum, side| sum += side }

    sides.any? { |s| (sum - s) <= s }
  end

end

class TriangleError < StandardError
end