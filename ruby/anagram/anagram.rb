class Anagram

  def initialize(word)
    @word = word.downcase
  end

  def match(words)
    words.select { |w| anagram?(w) }
  end

  private

  def anagram?(candidate)
    return false if @word == candidate.downcase

    @word.chars.sort == candidate.downcase.chars.sort
  end

end
