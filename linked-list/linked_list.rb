class Deque

  attr_reader :first, :last

  def push(value)
    node = Node.new(value)
    node.prev = last

    @last.next = node if last
    @last = node
    @first = node if first.nil?
  end

  def pop
    node = last

    @last = node.prev
    @last.next = nil if last
    @first = nil if node == first

    node.value
  end

  def shift
    node = first

    @first = node.next
    @first.prev = nil if first
    @last = nil if last == node

    node.next = nil
    node.value
  end

  def unshift(value)
    node = Node.new(value)
    node.next = first

    @first.prev = node if first
    @first = node
    @last = node if last.nil?
  end

  Node = Struct.new(:value, :next, :prev)

end
