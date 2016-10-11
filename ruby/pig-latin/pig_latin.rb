class PigLatin

  VOWELS = %w(a e o i u)

  def self.translate(phrase)
    idx = phrase.chars.index { |c| VOWELS.include?(c) }

    prefix, suffix = phrase.chars.slice(idx)

    puts "****** PHRASE: #{phrase} - IDX: #{idx} - PREFIX: #{phrase[0..(idx-1)]} - SUFFIX: #{suffix.inspect}"

    nil
  end

end
