# -*- coding: utf-8 -*-

# アヒル (Product)
class Duck
  def initialize(name)
    @name = name
  end

  def eat
    puts "アヒル #{@name} は食事中です"
  end
end

# カエル (Product)
class Frog
  def initialize(name)
    @name = name
  end

  def eat
    puts "カエル #{@name} は食事中です"
  end
end

# 池 (Creator)
class Pond
  def initialize(number_animals)
    @animals = []
    number_animals.times do |i|
      animal = new_animal("動物 #{i}")
      @animals << animal
    end
  end

  def simulate_one_day
    @animals.each { |animal| animal.eat}
  end
end

# DuckPond: 池のアヒルを生成する (ConcreteCreator)
class DuckPond < Pond
  def new_animal(name)
    Duck.new(name)
  end
end

# FrogPond: 池のカエルを生成する (ConcreteCreator)
class FrogPond < Pond
  def new_animal(name)
    Frog.new(name)
  end
end

# ===========================================
pond = DuckPond.new(3)
pond.simulate_one_day
#アヒル 動物 0 は食事中です
#アヒル 動物 1 は食事中です
#アヒル 動物 2 は食事中です

pond = FrogPond.new(2)
pond.simulate_one_day
#カエル 動物 0 は食事中です
#カエル 動物 1 は食事中です