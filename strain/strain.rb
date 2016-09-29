class Array

  def keep
    each_with_object([]) { |e, results| results << e if yield(e) }
  end

  def discard
    each_with_object([]) { |e, results| results << e unless yield(e) }
  end

end