module BookKeeping
  VERSION = 2
end

class RunLengthEncoding

  def self.encode(input)
    chunk_input(input).map { |letter,times| encode_letter(letter, times)  }.join
  end

  def self.decode(input)
    input.scan(/(\d*)(\D)/).map { |times,letter| decode_letter(letter, times) }.join
  end

  private

  def self.chunk_input(input)
    input.chars.chunk { |c| c }
  end

  def self.encode_letter(letter, times)
    if times.length > 1
      "#{times.length}#{letter}"
    else
      letter
    end
  end

  def self.decode_letter(letter, times)
    if times.empty?
      letter
    else
      letter * times.to_i
    end
  end

end