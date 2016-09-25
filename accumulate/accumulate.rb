class Array

  def accumulate
    acc = []
    each { |entry| acc << yield(entry) } if block_given?
    acc
  end

end