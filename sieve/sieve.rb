class Sieve

  def initialize(number)
    @range = 2..number
  end

  def primes
    primes = []
    unmarked = @range.to_a

    until unmarked.empty?
      primes << unmarked.shift
      unmarked -= multiples(primes.last)
    end

    primes
  end

  private

  def multiples(prime)
    @range.select { |num| num % prime == 0 }
  end

end