class Say

  ONES = %w(zero one two three four five six seven eight nine ten elevent twelve)
  TENS = (2..9).zip(%w(twenty thirty fourty fifty sixty seventy eighty ninety)).to_h

  def initialize(number)
    @number = number
  end

  def in_english
    return ONES[0] if @number.zero?

    parts = []
    num = @number

    while num > 0
      case num
      when 1..12
        parts << ONES[num]
        num -= num
      when 13..19
        parts << ONES[digits(num).last]
        parts << "teen"
        num -= num
      when 20..99
        tens, ones = *digits(num)
        # puts "********* TENS: #{tens} - ONES: #{ones} - DIGITS: #{digits.inspect}"
        parts << TENS[tens]
        parts << "-#{ONES[ones]}" if ones > 0
        num -= num
      when 100..999
        parts << ONES[digits(num).first]
        parts << " hundred "
        num = num % 100
      when 1000..9999
        parts << ONES[digits(num).first]
        parts << " thousand "
        num = num % 1000
      end
    end

    parts.join.strip
  end

  private

  def digits(num)
    num.to_s.chars.map(&:to_i)
  end

end