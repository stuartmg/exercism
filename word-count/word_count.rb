module BookKeeping
  VERSION = 1
end

class Phrase

  def initialize(input)
    @words = Hash.new(0)

    input.downcase.scan(/\b[\w\']+\b/).each { |w| @words[w] += 1 }
  end

  def word_count
    @words
  end

end
