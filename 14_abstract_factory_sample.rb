# -*- coding: utf-8 -*-

# Product
# 動物/アヒル
class Duck
  def initialize(name)
    @name = name
  end

  def eat
    puts("アヒル #{@name} は食事中です")
  end
end

# Product
# 動物/カエル
class Frog
  def initialize(name)
    @name = name
  end

  def eat
    puts("カエル #{@name} は食事中です")
  end
end

# Product
# 植物/藻
class Algae
  def initialize(name)
    @name = name
  end

  def grow
    puts "藻 #{@name} は成長中です"
  end
end

# Product
# 植物/スイレン
class WaterLily
  def initialize(name)
    @name = name
  end

  def grow
    puts "スイレン #{@name} は成長中です"
  end
end

# ConcreteFactory
# カエル(Flag)と藻(Algae)の生成を行う
class FlagAndAlgaeFactory
  def new_animal(name)
    Frog.new(name)
  end

  def new_plant(name)
    Algae.new(name)
  end
end

# ConcreteFactory
# アヒル(Duck)とスイレン(WaterLily)の生成を行う
class DuckAndWaterLilyFactory
  def new_animal(name)
    Duck.new(name)
  end

  def new_plant(name)
    WaterLily.new(name)
  end
end

# AbstractFactory
# 池
class Pond
  def initialize(number_animals, number_plants, organism_factory)
    @animals = []
    # 池の動物を定義する
    number_animals.times do |i|
      animal = organism_factory.new_animal("動物 #{i}")
      @animals << animal
    end

    @plants = []
    # 池の植物を定義する
    number_plants.times do |i|
      plant = organism_factory.new_plant("植物　#{i}")
      @plants << plant
    end
  end

  # 池の今をシミュレートする
  def simulate_now
    @plants.each { |plant| plant.grow}
    @animals.each { |animal| animal.eat}
  end
end

# ===========================================
pond = Pond.new(1, 4, FlagAndAlgaeFactory.new)
pond.simulate_now
#藻 植物　0 は成長中です
#藻 植物　1 は成長中です
#藻 植物　2 は成長中です
#藻 植物　3 は成長中です
#カエル 動物 0 は食事中です

pond = Pond.new(2, 3, DuckAndWaterLilyFactory.new)
pond.simulate_now
#スイレン 植物　0 は成長中です
#スイレン 植物　1 は成長中です
#スイレン 植物　2 は成長中です
#アヒル 動物 0 は食事中です
#アヒル 動物 1 は食事中です