module BookKeeping
  VERSION = 1
end

class Acronym

  def self.abbreviate(phrase)
    abbr = phrase.scan(/\w+/).map do |word|
      next if word.empty?

      if word.upcase == word || word.downcase == word
        word[0].upcase
      else
        word.gsub(/[a-z]/, '').upcase
      end
    end

    abbr.join
  end

end
