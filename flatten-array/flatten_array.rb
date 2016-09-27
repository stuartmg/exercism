class FlattenArray

  VERSION = 1

  def self.flatten(nested)
    return [] if nested.nil? || nested.empty?

    head = nested.first
    tail = nested.slice(1..-1)

    if head.nil?
      [] + flatten(tail)
    elsif head.class == Array
      flatten(head) + flatten(tail)
    else
      [head] + flatten(tail)
    end
  end

end
