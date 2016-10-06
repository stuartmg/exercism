class Luhn

  def initialize(number)
    @digits = number.to_s.chars.map(&:to_i)
  end

  def addends
    @digits.reverse.each_with_index.map { |digit, idx| process_digit(digit,idx) }.reverse
  end

  def checksum
    addends.reduce(&:+)
  end

  def valid?
    checksum % 10 == 0
  end

  def self.create(number)
    checksum = Luhn.new("#{number}0").checksum

    check_digit = 10 - (checksum % 10)
    check_digit = 0 if check_digit == 10

    "#{number}#{check_digit}".to_i
  end

  private

  def process_digit(digit, idx)
    num = digit
    num *= 2 if idx.odd?

    num > 10 ? num - 9 : num
  end

end