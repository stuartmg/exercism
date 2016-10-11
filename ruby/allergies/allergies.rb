class Allergies

  FOODS = {
    eggs: 1,
    peanuts: 2,
    shellfish: 4,
    strawberries: 8,
    tomatoes: 16,
    chocolate: 32,
    pollen: 64,
    cats: 128
  }

  def initialize(score)
    @score = score
  end

  def allergic_to?(food)
    @score & FOODS[food.to_sym] > 0
  end

  def list
    FOODS.keys.map(&:to_s).select { |food| allergic_to?(food) }
  end

end
