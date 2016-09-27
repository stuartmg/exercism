module BookKeeping
  VERSION = 1
end

class Acronym

  def self.abbreviate(phrase)
    phrase.scan(/[A-Z]+[a-z]*|[a-z]+/).map { |word| word[0].upcase }.join
  end

end
