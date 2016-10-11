module BookKeeping
  VERSION = 2
end

class BeerSong

  def verse(num)
    "#{inventory(num).capitalize} of beer on the wall, #{inventory(num)} of beer.\n" \
      "#{action(num)}, #{remaining(num)} of beer on the wall.\n"
  end

  def verses(start, finish)
    start.downto(finish).map { |n| verse(n) }.join("\n")
  end

  def lyrics
    verses(99, 0)
  end

  private

  def action(num)
    case num
      when 0 then "Go to the store and buy some more"
      when 1 then "Take it down and pass it around"
      else "Take one down and pass it around"
    end
  end

  def inventory(num)
    num == 0 ? "no more bottles" : "#{num} #{vessel(num)}"
  end

  def remaining(num)
    remaining = num - 1
    remaining = 99 if remaining < 0

    inventory(remaining)
  end

  def vessel(num)
    num > 1 ? "bottles" : "bottle"
  end

end