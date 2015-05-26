# -*- coding: utf-8 -*-

# 動物/アヒル (Product)
class Duck
  def initialize(name)
    @name = name
  end

  def eat
    puts("アヒル #{@name} は食事中です")
  end
end

# 動物/カエル (Product)
class Frog
  def initialize(name)
    @name = name
  end

  def eat
    puts("カエル #{@name} は食事中です")
  end
end

# 植物/藻 (Product)
class Algae
  def initialize(name)
    @name = name
  end

  def grow
    puts "藻 #{@name} は成長中です"
  end
end

# 植物/スイレン (Product)
class WaterLily
  def initialize(name)
    @name = name
  end

  def grow
    puts "スイレン #{@name} は成長中です"
  end
end

# 池の生態系を作る (Abstract Factory)
class OrganismFactory
  def initialize(number_animals, number_plants)
    @animals = []
    # 池の動物を定義する
    number_animals.times do |i|
      animal = new_animal("動物 #{i}")
      @animals << animal
    end

    @plants = []
    # 池の植物を定義する
    number_plants.times do |i|
      plant = new_plant("植物 #{i}")
      @plants << plant
    end
  end

  # 植物についてのオブジェクトを返す
  def get_plants
		@plants
	end

  # 動物についてのオブジェクトを返す
	def get_animals
		@animals
	end
end

# カエル(Frog)と藻(Algae)の生成を行う (Concrete Factory)
class FrogAndAlgaeFactory < OrganismFactory
	private

  def new_animal(name)
    Frog.new(name)
  end

  def new_plant(name)
    Algae.new(name)
  end
end

# アヒル(Duck)とスイレン(WaterLily)の生成を行う(Concrete Factory)
class DuckAndWaterLilyFactory < OrganismFactory
	private

  def new_animal(name)
    Duck.new(name)
  end

  def new_plant(name)
    WaterLily.new(name)
  end
end

# ===========================================
factory = FrogAndAlgaeFactory.new(4,1)
animals = factory.get_animals
animals.each { |animal| animal.eat }
#=> カエル 動物 0 は食事中です
#=> カエル 動物 1 は食事中です
#=> カエル 動物 2 は食事中です
#=> カエル 動物 3 は食事中です
plants = factory.get_plants
plants.each { |plant| plant.grow }
#=> 藻 植物 0 は成長中です

factory = DuckAndWaterLilyFactory.new(3,2)
animals = factory.get_animals
animals.each { |animal| animal.eat }
#=> アヒル 動物 0 は食事中です
#=> アヒル 動物 1 は食事中です
#=> アヒル 動物 2 は食事中です
plants = factory.get_plants
plants.each { |plant| plant.grow }
#=> スイレン 植物 0 は成長中です
#=> スイレン 植物 1 は成長中です
