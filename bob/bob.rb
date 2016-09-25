class Bob

  def hey(phrase)
    case
      when yelling?(phrase) then "Whoa, chill out!"
      when silence?(phrase) then "Fine. Be that way!"
      when question?(phrase) then "Sure."
      else "Whatever."
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