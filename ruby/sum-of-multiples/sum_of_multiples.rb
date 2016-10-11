require 'set'

class SumOfMultiples

  def initialize(*numbers)
    @numbers = numbers
  end

  def to(limit)
    results = @numbers.reduce(Set.new) { |set,num| set.merge multiples(num,limit) }

    results.reduce(0, :+)
  end

  private

  def multiples(number, limit)
    multiples = []
    counter = 1

    while (number * counter) < limit
      multiples << (number * counter)
      counter += 1
    end

    multiples
  end

end