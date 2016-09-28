module BookKeeping
  VERSION = 3
end

class Brackets

  MATCHING_BRACKETS = ["}", "]", ")"].zip(["{", "[", "("]).to_h

  def self.paired?(input)
    stack = []

    brackets(input).each do |char|
      if closing_bracket?(char) && stack.last == MATCHING_BRACKETS[char]
        stack.pop
      else
        stack.push char
      end
    end

    stack.empty?
  end

  def self.brackets(input)
    input.gsub(/[^\[\]\{\}\(\)]/, '').chars
  end

  def self.closing_bracket?(char)
    MATCHING_BRACKETS.has_key?(char)
  end

end
