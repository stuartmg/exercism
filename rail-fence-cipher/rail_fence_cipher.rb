class RailFenceCipher

  VERSION = 1

  def initialize(num_rails)
    @num = num_rails || 1

    @rails = Array.new(@num) { |idx| [] }
    @cycle = (0..(@num - 1)).to_a + (1..(@num-2)).to_a.reverse

    @index = 0
  end

  def self.encode(plaintext, num_rails)
    RailFenceCipher.new(num_rails).encode(plaintext)
  end

  def self.decode(ciphertext, num_rails)
    RailFenceCipher.new(num_rails).decode(ciphertext)
  end

  def encode(plaintext)
    build_fence(plaintext.chars).flatten.join
  end

  def decode(ciphertext)
    range = (0..(ciphertext.length - 1))
    fence = build_fence(range.to_a).flatten

    range.map { |num| ciphertext[fence.index(num)] }.join
  end

  private

  def next_index
    idx = @index % @cycle.length
    @index += 1

    @cycle[idx]
  end

  def build_fence(input)
    input.each_with_object(@rails) { |c, rails| rails[next_index] << c }
  end

end
