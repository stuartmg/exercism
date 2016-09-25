class PrimeFactors

  def self.for(number)
    results = []
    remaining = number
    factor = 2

    while remaining > 1
      if remaining % factor == 0
        results << factor
        remaining /= factor
      else
        factor += 1
      end
    end

    results
  end

end