class Prime

  def self.nth(count)
    raise ArgumentError if count < 1

    primes(count).last
  end

  def self.primes(count)
    primes = []

    while primes.length < count
      primes << next_prime((primes.last || 0) + 1)
    end

    primes
  end

  def self.next_prime(start)
    num = start
    num += 1 until prime?(num)
    num
  end

  # primality test ( see wikipedia )
  def self.prime?(number)
    return false if number <= 1
    return true if number <= 3
    return false if number % 2 == 0
    return false if number % 3 == 0

    i = 5

    while i*i <= number
      return false if number % i == 0
      return false if number % (i+2) == 0
      i += 6
    end

    true
  end

  private_class_method :primes, :next_prime, :prime?

end