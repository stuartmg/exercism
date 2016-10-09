module BookKeeping
  VERSION = 2
end

class ListOps

  def self.arrays(arr)
    reduce(arr, 0) { |sum, el| sum += 1 }
  end

  def self.reverser(arr)
    reduce(arr, []) { |acc, el| acc.unshift(el) }
  end

  def self.concatter(arr1, arr2)
    reduce(arr2, arr1) { |acc, el| acc << el }
  end

  def self.mapper(arr)
    reduce(arr, []) { |acc, el| acc << yield(el) }
  end

  def self.filterer(arr)
    reduce(arr, []) do |acc, el|
      acc.push(el) if yield(el)
      acc
    end
  end

  def self.sum_reducer(arr)
    reduce(arr, 0) { |sum, el| sum += el.to_i }
  end

  def self.factorial_reducer(arr)
    reduce(arr, 1) { |sum, el| sum *= el.to_i }
  end

  def self.reduce(arr, memo)
    a = Array.new(arr)
    memo = yield(memo, a.shift) until a.empty?
    memo
  end

  private_class_method :reduce

end
