module BookKeeping
  VERSION = 2
end

class Integer

  def to_roman
    val = self
    roman = ""

    val, roman = convert_roman(val, roman, 1000, "M")
    val, roman = convert_roman(val, roman, 900, "CM")
    val, roman = convert_roman(val, roman, 500, "D")
    val, roman = convert_roman(val, roman, 400, "CD")
    val, roman = convert_roman(val, roman, 100, "C")
    val, roman = convert_roman(val, roman, 90, "XC")
    val, roman = convert_roman(val, roman, 50, "L")
    val, roman = convert_roman(val, roman, 40, "XL")
    val, roman = convert_roman(val, roman, 10, "X")
    val, roman = convert_roman(val, roman, 9, "IX")
    val, roman = convert_roman(val, roman, 5, "V")
    val, roman = convert_roman(val, roman, 4, "IV")
    val, roman = convert_roman(val, roman, 1, "I")

    roman
  end

  private

  def convert_roman(value, roman, num, letter)
    while value >= num
      roman << letter
      value -= num
    end

    return value, roman
  end

end
