class Series

  def initialize(number)
    @numbers = number.chars.map { |c| c.to_i }
  end

  def slices(length)
    raise ArgumentError, "Slice too large" if length > @numbers.length

    (0..(@numbers.length - length)).map { |start| @numbers.slice(start, length) }
  end

end
