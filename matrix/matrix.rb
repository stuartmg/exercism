class Matrix

  attr_accessor :rows, :columns

  def initialize(input)
    @rows = []

    input.split("\n").each do |row|
      @rows << row.split(" ").map(&:to_i)
    end

    @columns = @rows.transpose
  end

end
