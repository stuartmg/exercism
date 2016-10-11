class Series

  def initialize(number)
    @numbers = number.chars.map(&:to_i)
  end

  def slices(length)
    raise ArgumentError, "Slice too large" if length > @numbers.length

    @numbers.each_cons(length).to_a
  end

end
