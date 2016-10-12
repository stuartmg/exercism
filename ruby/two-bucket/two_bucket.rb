module BookKeeping
  VERSION = 2
end

class TwoBucket

  attr_accessor :bucket_one, :bucket_two, :target, :moves, :goal_bucket, :other_bucket

  def initialize(capacity_one, capacity_two, target, fill_first)
    @bucket_one = Bucket.new(capacity_one)
    @bucket_two = Bucket.new(capacity_two)
    @target = target
    @moves = 0

    self.send("#{fill_first}_first")

    if bucket_one.volume == target
      @goal_bucket = 'one'
      @other_bucket = bucket_two.volume
    end

    if bucket_two.volume == target
      @goal_bucket = 'two'
      @other_bucket = bucket_one.volume
    end
  end

  private

  def one_first
    until target_reached?
      case
      when bucket_one.empty? then bucket_one.fill
      when !bucket_two.full? then bucket_one.into(bucket_two)
      when bucket_two.full?  then bucket_two.drain
      end
      @moves += 1
    end
  end

  def two_first
    until target_reached?
      case
      when bucket_two.empty? then bucket_two.fill
      when !bucket_one.full? then bucket_two.into(bucket_one)
      when bucket_one.full?  then bucket_one.drain
      end
      @moves += 1
    end
  end

  def target_reached?
    bucket_one.volume == target || bucket_two.volume == target
  end

end

class Bucket

  attr_accessor :capacity, :volume

  def initialize(capacity, volume = 0)
    @capacity = capacity
    @volume = volume
  end

  def full?
    volume == capacity
  end

  def fill
    @volume = capacity
  end

  def drain
    @volume = 0
  end

  def empty?
    volume == 0
  end

  def space
    capacity - volume
  end

  def into(bucket)
    if volume <= bucket.space
      bucket.volume += volume
      @volume = 0
    else
      @volume -= bucket.space
      bucket.fill
    end
  end

end