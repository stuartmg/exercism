class Element

  attr_accessor :datum, :next

  def initialize(value, next_element = nil)
    @datum = value
    @next = next_element
  end

  def tail?
    @next.nil?
  end

end

class SimpleLinkedList

  attr_reader :head

  def initialize
    @head = nil
  end

  def self.from_a(list)
    return SimpleLinkedList.new if list.nil?

    list.reverse.each_with_object(SimpleLinkedList.new) { |el, ll| ll.push(el) }
  end

  def reverse
    SimpleLinkedList.from_a(to_a.reverse)
  end

  def push(value)
    @head = Element.new(value, head)
  end

  def pop
    el = head
    @head = el.next

    el.next = nil
    el.datum
  end

  def peek
    @head.nil? ? nil : @head.datum
  end

  def size
    to_a.length
  end

  def empty?
    @head.nil?
  end

  def to_a
    results = []
    node = @head

    while node != nil
      results << node.datum
      node = node.next
    end

    results
  end

end
