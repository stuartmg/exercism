class Bst

  VERSION = 1

  attr_reader :data, :left, :right

  def initialize(data)
    @data = data
  end

  def insert(value)
    value <= data ? insert_left(value) : insert_right(value);
  end

  def each(&block)
    return enum_for(:each) unless block_given?

    left.each(&block) if left
    block.call(data)
    right.each(&block) if right
  end

  private

  def insert_left(value)
    if left.nil?
      @left = Bst.new(value)
    else
      left.insert(value)
    end
  end

  def insert_right(value)
    if right.nil?
      @right = Bst.new(value)
    else
      right.insert(value)
    end
  end

end