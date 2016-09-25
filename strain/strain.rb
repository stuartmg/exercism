class Array

  def keep
    results = []
    each { |e| results << e if yield(e) }
    results
  end

  def discard
    results = []
    each { |e| results << e unless yield(e) }
    results
  end

end