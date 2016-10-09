class Queens

  DEFAULT_OPTIONS = {
    white: [0,3],
    black: [7,3]
  }.freeze

  def initialize(options = {})
    @options = DEFAULT_OPTIONS.merge(options)

    raise ArgumentError, "Pieces can't occupy the same space" if same_space?
  end

  def white
    @options[:white]
  end

  def black
    @options[:black]
  end

  def attack?
    same_row? || same_column? || same_diagonal?
  end

  def to_s
    (0..7).map do |row|
      (0..7).map do |col|
        case
        when white == [row,col] then "W"
        when black == [row,col] then "B"
        else "_"
        end
      end.join(" ")
    end.join("\n")
  end

  private

  def same_space?
    white == black
  end

  def same_row?
    white[0] == black[0]
  end

  def same_column?
    white[1] == black[1]
  end

  def same_diagonal?
    (black[0] - white[0]).abs == (black[1] - white[1]).abs
  end

end
