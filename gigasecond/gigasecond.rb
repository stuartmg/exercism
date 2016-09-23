module BookKeeping
  VERSION = 4
end

class Gigasecond

  def self.from(birthday)
    Time.at(birthday.to_i + 1_000_000_000).utc
  end

end