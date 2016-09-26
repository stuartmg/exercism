class Alphametics

  DIGITS = (0..9).to_a

  def solve(puzzle)
    puzzle.gsub!(/\^/, '**')
    words = puzzle.scan /[A-Z]+/
    chars = words.join.chars.uniq

    # get the first letter of each word because they can't be zero
    first_chars = words.select{|w| w.length > 1}.map{|w| w[0]}.uniq

    # create an ordered array where the first characters of each word come first
    sorted = (first_chars + (chars - first_chars)).to_a.join

    match = DIGITS.permutation(chars.length).find do |guess|
      # if the guess would assign a zero to one of the first characters, skip it
      if guess[0, first_chars.length].member?(0)
        false
      else
        expr = puzzle.tr sorted, guess.join
        eval expr
      end
    end

    match.nil? ? nil : sorted.chars.zip(match).to_h
  end

end

module BookKeeping
  VERSION = 2
end
