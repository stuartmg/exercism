module BookKeeping
  VERSION = 2
end

class Robot

  @@previous_names = []

  def initialize
    @letters = ('A'..'Z').to_a
    reset
  end

  def name
    @name
  end

  def reset
    while @@previous_names.include?(@name)
      @name = generate_name
    end

    @@previous_names << @name
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