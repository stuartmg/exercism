class InvalidCodonError < StandardError
end

class Translation

  CODONS = {
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UGG" => "Tryptophan",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  def self.of_codon(codon)
    raise InvalidCodonError unless CODONS[codon]

    CODONS[codon]
  end

  def self.of_rna(rna)
    rna.chars.each_slice(3).map { |s| of_codon(s.join) }.take_while { |el| el != "STOP" }
  end


end
