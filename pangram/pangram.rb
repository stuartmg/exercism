module BookKeeping
  VERSION = 2
end

class Pangram

  def self.is_pangram?(string)
    str = string.downcase

    ('a'..'z').all? { |letter| str.include?(letter) }
  end

end