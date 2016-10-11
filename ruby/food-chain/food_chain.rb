module BookKeeping
  VERSION = 2
end

class FoodChain

  ANIMALS = %w(fly spider bird cat dog goat cow horse)

  REACTIONS = {
    spider: "It wriggled and jiggled and tickled inside her.",
    bird: "How absurd to swallow a bird!",
    cat: "Imagine that, to swallow a cat!",
    dog: "What a hog, to swallow a dog!",
    goat: "Just opened her throat and swallowed a goat!",
    cow: "I don't know how she swallowed a cow!",
    horse: "She's dead, of course!"
  }

  REASONS = {
    fly: "I don't know why she swallowed the fly. Perhaps she'll die.\n",
    spider: "She swallowed the spider to catch the fly.",
    bird: "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
    cat: "She swallowed the cat to catch the bird.",
    dog: "She swallowed the dog to catch the cat.",
    goat: "She swallowed the goat to catch the dog.",
    cow: "She swallowed the cow to catch the goat."
  }

  def self.song
    parts = []
    reasons = []

    ANIMALS.each do |animal|
      parts << "I know an old lady who swallowed a #{animal}."

      if REACTIONS[animal.to_sym]
        parts << REACTIONS[animal.to_sym]
      end

      if REASONS[animal.to_sym]
        reasons.unshift REASONS[animal.to_sym]
        reasons.each { |reason| parts << reason }
      end
    end

    parts.join("\n") + "\n"
  end

end
