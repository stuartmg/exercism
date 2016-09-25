class Bob

  def hey(phrase)
    if yelling?(phrase)
      "Whoa, chill out!"
    elsif silence?(phrase)
      "Fine. Be that way!"
    elsif question?(phrase)
      "Sure."
    else
      "Whatever."
    end
  end

  private

  def yelling?(phrase)
    phrase.upcase == phrase && phrase.match(/\p{Alpha}/)
  end

  def silence?(phrase)
    phrase.strip.empty?
  end

  def question?(phrase)
    phrase.end_with? "?"
  end

end