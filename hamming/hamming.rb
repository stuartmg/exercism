module BookKeeping
  VERSION = 3
end

class Hamming

  def self.compute(strand1, strand2)
    raise ArgumentError if strand1.length != strand2.length

    nucleotide_pairs(strand1, strand2).count { |n| n[0] != n[1] }
  end

  private

  def self.nucleotide_pairs(strand1, strand2)
    nucleotides(strand1).zip(nucleotides(strand2))
  end

  def self.nucleotides(strand)
    strand.chars
  end

end