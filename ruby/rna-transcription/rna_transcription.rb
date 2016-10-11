module BookKeeping
  VERSION = 4
end

class Complement

  def self.of_dna(strand)
    return "" unless valid?(strand)

    strand.tr("GCTA", "CGAU")
  end

  private

  def self.valid?(strand)
    strand.match /\A[ACTG]+\z/
  end

end