class Cipher

  attr_reader :key

  def initialize(key = nil)
    @key = key || random_key

    raise ArgumentError, "invalid key" unless valid?
  end

  def encode(plaintext)
    plaintext.chars.each_with_index.map { |c, i| encode_letter(c, i) }.join
  end

  def decode(ciphertext)
    ciphertext.chars.each_with_index.map { |c, i| decode_letter(c, i) }.join
  end

  private

  def random_key
    range = ('a'..'z').to_a
    Array.new(100) { range.sample }.join
  end

  def valid?
    @key.match /\A[a-z]+\z/
  end

  def encode_letter(letter, index)
    offset = (letter_value(letter) + letter_offset(index)) % 26
    ('a'.ord + offset).chr
  end

  def decode_letter(letter, index)
    offset = (letter_value(letter) - letter_offset(index)) % 26
    ('a'.ord + offset).chr
  end

  def letter_value(letter)
    letter.ord - 'a'.ord
  end

  def letter_offset(index)
    (key[index].ord - 'a'.ord) % 26
  end

end