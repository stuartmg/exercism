class Crypto

  def initialize(plaintext)
    @plaintext = plaintext
  end

  def normalize_plaintext
    @plaintext.downcase.gsub(/\W/, '')
  end

  def plaintext_segments
    normalize_plaintext.chars.each_slice(size).map { |slice| slice.join }
  end

  def ciphertext
    first, *rest = *normalize_plaintext.chars.each_slice(size).to_a
    first.zip(*rest).join
  end

  def normalize_ciphertext
    text = ciphertext
    num = Math.sqrt(text.length).ceil
    division, modulo = text.length.divmod num

    groups = []
    start = 0

    num.times do |index|
      length = division + (modulo > 0 && modulo > index ? 1 : 0)
      groups << last_group = text.slice(start, length)
      start += length
    end

    groups.join " "
  end

  def size
    Math.sqrt(normalize_plaintext.length).ceil
  end

end