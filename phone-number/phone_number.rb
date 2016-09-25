class PhoneNumber

  attr_reader :number

  def initialize(number)
    @number = clean_number(number)
  end

  def area_code
    number.slice(0, 3)
  end

  def to_s
    "(#{area_code}) #{prefix}-#{suffix}"
  end

  private

  def prefix
    number.slice(3, 3)
  end

  def suffix
    number.slice(6..-1)
  end

  def clean_number(number)
    return "0000000000" unless number.gsub(/[\(\)\-\. ]/, '').match(/\A\d+\z/)

    num = number.gsub(/\D/, '')
    num = num.slice(1..-1) if num.length == 11 && num[0] == '1'
    num = "0000000000" unless num.length == 10
    num
  end

end
