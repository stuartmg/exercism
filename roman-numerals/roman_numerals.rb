module BookKeeping
  VERSION = 2
end

class Integer

  ROMAN_NUMERALS = {
    "M": 1000,
    "CM": 900,
    "D": 500,
    "CD": 400,
    "C": 100,
    "XC": 90,
    "L": 50,
    "XL": 40,
    "X": 10,
    "IX": 9,
    "V": 5,
    "IV": 4,
    "I": 1
  }

  def to_roman
    val = self
    roman = ""

    ROMAN_NUMERALS.each do |k,v|
      while val >= v
        roman << k.to_s
        val -= v
      end
    end

    roman
  end

end
