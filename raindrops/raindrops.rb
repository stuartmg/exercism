module BookKeeping
  VERSION = 2
end

class Raindrops

  def self.convert(number)
    result = ""

    result << "Pling" if factor?(number, 3)
    result << "Plang" if factor?(number, 5)
    result << "Plong" if factor?(number, 7)
    result << number.to_s if result.empty?

    result
  end

  private

  def self.factor?(number, factor)
    (number % factor) == 0
  end

end