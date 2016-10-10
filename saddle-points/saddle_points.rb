class Matrix

  attr_reader :rows

  def initialize(grid)
    @rows = grid.split("\n").map { |row| row.split(" ").map(&:to_i) }
  end

  def columns
    rows.transpose
  end

  def saddle_points
    columns.map(&:min).each_with_object([]) do |val, acc|
      rows.each_with_index do |row, row_num|
        acc << [row_num, row.index(val)] if row.max == val
      end
    end
  end

end
