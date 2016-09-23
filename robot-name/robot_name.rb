module BookKeeping
  VERSION = 2
end

class Robot

  def initialize
    @letters = ('A'..'Z').to_a
  end

  def name
    @name ||= generate_name
  end

  def reset
    @name = nil
  end

  private

  def generate_name
    [name_prefix, name_suffix].join
  end

  def name_prefix
    @letters.shuffle!(random: Random.new)
    @letters.slice(0,2).join
  end

  def name_suffix
    Random.rand(100..999)
  end

end