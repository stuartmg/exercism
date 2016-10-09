module BookKeeping
  VERSION = 1
end

class CustomSet

  include Enumerable

  def initialize(values = [])
    @values = values.uniq
  end

  def add(value)
    values << value unless member?(value)
    self
  end

  def empty?
    values.empty?
  end

  def subset?(set)
    self.all? { |el| set.member?(el) }
  end

  def disjoint?(set)
    set.none? { |el| member?(el) }
  end

  def intersection(set)
    CustomSet.new self.select { |el| set.member?(el) }
  end

  def difference(set)
    CustomSet.new self.reject { |el| set.member?(el) }
  end

  def union(set)
    CustomSet.new entries + set.entries
  end

  def each
    a = Array.new(values)
    yield a.shift until a.empty?
  end

  def ==(set)
    self.class == set.class && entries.sort == set.entries.sort
  end

  private

  attr_accessor :values

end
