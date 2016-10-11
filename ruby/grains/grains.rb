class Grains

  def self.square(number)
    1 << (number - 1)
  end

  def self.total
    (1..64).reduce { |sum,n| sum + square(n) }
  end

end