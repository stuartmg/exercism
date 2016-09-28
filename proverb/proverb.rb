class Proverb

  def initialize(*parts, qualifier: nil)
    @parts = []

    parts.each_cons(2) do |part1, part2|
      @parts << "For want of a #{part1} the #{part2} was lost."
    end

    final_part = [qualifier, parts.first].compact.join " "

    @parts << "And all for the want of a #{final_part}."
  end

  def to_s
    @parts.join "\n"
  end

end
