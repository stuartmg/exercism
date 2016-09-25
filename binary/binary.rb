module BookKeeping
  VERSION = 2
end

class Binary

  def initialize(binary)
    raise ArgumentError, "Not binary input" unless binary.match(/\A[0-1]+\z/)

    @binary = binary
  end

  def to_decimal
    @binary.reverse.chars.each_with_index.reduce(0) do |sum, (digit, idx)|
      sum += digit.to_i * (2 ** idx)
    end
  end


end