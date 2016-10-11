class Nucleotide

  def initialize(strand)
    raise ArgumentError, "Not a valid DNA strand" unless valid?(strand)

    @strand = strand || ""
  end

  def self.from_dna(strand)
    Nucleotide.new(strand)
  end

  def count(nucleotide)
    @strand.chars.count(nucleotide)
  end

  def histogram
    @strand.chars.each_with_object(default_historgram) { |n, h| h[n] += 1; }
  end

  private

  def default_historgram
    { 'A' => 0, 'T' => 0, 'C' => 0, 'G' => 0 }
  end

  def valid?(strand)
    strand.match(/\A[ATCG]*\z/)
  end

end
