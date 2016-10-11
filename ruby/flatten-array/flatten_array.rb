class FlattenArray

  VERSION = 1

  def self.flatten(nested)
    nested.each_with_object([]) do |el, flattened|
      if el.is_a? Array
        flattened.push *flatten(el)
      else
        flattened << el if el
      end
    end
  end

end
