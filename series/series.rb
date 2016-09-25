class Series

  def initialize(number)
    @numbers = number.chars.map { |c| c.to_i }
  end

  def slices(length)
    raise ArgumentError, "Slice too large" if length > @numbers.length

    @numbers.each_cons(length).map { |slice| slice }
  end

end
