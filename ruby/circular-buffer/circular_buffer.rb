class CircularBuffer

  class BufferEmptyException < Exception
  end

  class BufferFullException < Exception
  end

  def initialize(size)
    @size = size
    init_buffer
  end

  def read
    raise BufferEmptyException if buffer.compact.empty?
    result = buffer.at(read_index)
    buffer[read_index] = nil
    advance_read_index
    result
  end

  def write(val)
    raise BufferFullException if full?
    buffer[write_index] = val
    advance_write_index
  end

  def write!(val)
    prev_full = full?
    buffer[write_index] = val
    advance_write_index
    advance_read_index if prev_full
  end

  def clear
    init_buffer
  end

  private

  attr_accessor :buffer, :read_index, :write_index, :size

  def init_buffer
    @buffer = Array.new(size)
    @read_index = 0
    @write_index = 0
  end

  def advance_read_index
    self.read_index = (read_index + 1) % size
  end

  def advance_write_index
    self.write_index = (write_index + 1) % size
  end

  def full?
    buffer.compact.length == size
  end

end
