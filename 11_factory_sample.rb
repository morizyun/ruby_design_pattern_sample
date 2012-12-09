# -*- coding: utf-8 -*-

# アヒル
class Duck
  def initialize(name)
    @name = name
  end

  def eat
    puts("アヒル #{@name} は食事中です")
  end
end

# カエル
class Frog
  def initialize(name)
    @name = name
  end

  def eat
    puts("カエル #{@name} は食事中です")
  end
end

# 池
class Pond
  def initialize(animal_factory, number_animals)
    @animals = []
    number_animals.times do |i|
      animal = animal_factory.new_animal("Animal#{i}")
      @animals << animal
    end
  end

  def simulate_one_day
    @animals.each { |animal| animal.eat}
  end
end

  # Factory 動物を生成する
class AnimalFactory
  def initialize(animal_class)
    @animal_class = animal_class
  end

  def new_animal(name)
    @animal_class.new(name)
  end
end

# ===========================================
pond = Pond.new(AnimalFactory.new(Duck), 3)
pond.simulate_one_day
#アヒル Animal0 は食事中です
#アヒル Animal1 は食事中です
#アヒル Animal2 は食事中です

pond = Pond.new(AnimalFactory.new(Frog), 2)
pond.simulate_one_day
#カエル Animal0 は食事中です
#カエル Animal1 は食事中です