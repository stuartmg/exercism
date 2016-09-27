class Scrabble

  def initialize(word)
    @word = word || ""
  end

  def score
    @word.chars.reduce(0) { |sum,letter| sum + letter_score(letter) }
  end

  def self.score(word)
    Scrabble.new(word).score
  end

  private

  def letter_score(letter)
    case letter.upcase
    when "A", "E", "I", "O", "U", "L", "N", "R", "S", "T" then 1
    when "D", "G" then 2
    when "B", "C", "M", "P" then 3
    when "F", "H", "V", "W", "Y" then 4
    when "K" then 5
    when "J", "X" then 8
    when "Q", "Z" then 10
    else 0
    end
  end

end