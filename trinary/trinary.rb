module BookKeeping
  VERSION = 1
end

class Trinary

  def initialize(trinary)
    @trinary = trinary
  end

  def to_decimal
    return 0 unless @trinary.match(/\A[0-2]+\z/)

    trinary_digits.each_with_index.reduce(0) do |sum,(num,idx)|
      sum += num * 3 ** idx
    end
  end

  private

  def trinary_digits
    @trinary.reverse.chars.map(&:to_i)
  end

end
