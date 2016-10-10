class Matrix

  attr_reader :rows

  def initialize(grid)
    @rows = grid.split("\n").map { |row| row.split(" ").map(&:to_i) }
  end

  def columns
    rows.transpose
  end

  def saddle_points
    largest_in_rows & smallest_in_columns
  end

  private

  def largest_in_rows
    rows.each_with_index.reduce([]) do |acc, (row, row_num)|
      row.each_with_index.each do |val, col_num|
        acc << [row_num, col_num] if val == row.max
      end
      acc
    end
  end

  def smallest_in_columns
    columns.each_with_index.reduce([]) do |acc, (col, col_num)|
      col.each_with_index.each do |val, row_num|
        acc << [row_num, col_num] if val == col.min
      end
      acc
    end
  end

end
