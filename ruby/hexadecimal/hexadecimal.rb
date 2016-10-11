class Hexadecimal

  VALUES = '0123456789ABCDEF'.chars.zip(0..15).to_h

  def initialize(hex)
    @hex = hex.upcase
  end

  def to_decimal
    return 0 unless valid?

    digits.each_with_index.reduce(0) { |sum, (num,idx)| sum += num * 16 ** idx}
  end

  private

  def valid?
    @hex.match(/\A[\dA-F]+\z/)
  end

  def digits
    @hex.chars.reverse.map { |c| VALUES[c] }
  end

end