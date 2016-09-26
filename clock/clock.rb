module BookKeeping
  VERSION = 2
end

class Clock

  attr_reader :hours, :minutes

  def initialize(h, m)
    @minutes = m % 60
    @hours = (h + m / 60) % 24
  end

  def self.at(h, m)
    Clock.new(h, m)
  end

  def +(m)
    Clock.new(hours, minutes + m)
  end

  def to_s
    "%02d:%02d" % [ hours, minutes ]
  end

  def ==(clock)
    return true if clock.equal?(self)

    clock.instance_of?(self.class) && hours == clock.hours && minutes == clock.minutes
  end

end