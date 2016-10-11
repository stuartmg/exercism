class Palindromes

  attr_reader :min, :max, :palindromes

  def initialize(options = {})
    @min = options[:min_factor] || 1
    @max = options[:max_factor] || 10
    @palindromes = Hash.new { |hash,key| hash[key] = [] }
  end

  def generate
    candidates.select { |a,b| palindrome?(a,b) }.each do |a,b|
      palindromes[a * b] << [a,b]
    end
  end

  def smallest
    key = palindromes.keys.min
    Palindrome.new(key, palindromes[key])
  end

  def largest
    key = palindromes.keys.max
    Palindrome.new(key, palindromes[key])
  end

  private

  def candidates
    (min..max).to_a.combination(2).to_a + (min..max).map { |num| [num,num] }
  end

  def palindrome?(a, b)
    str = (a * b).to_s
    str == str.reverse
  end

  Palindrome = Struct.new(:value, :factors)

end
