# -*- coding: utf-8 -*-

# SugarWater： 砂糖水クラス (ConcreteBuilder：ビルダーの実装部分)
class SugarWater
  attr_accessor :water, :sugar
  def initialize(water, sugar)
    @water = water
    @sugar = sugar
  end
end

# SugarWaterBuilder： 砂糖水クラス (Builder)
class SugarWaterBuilder
  def initialize
    @sugar_water = SugarWater.new(0,0)
  end

  # 砂糖を加える
  def add_sugar(sugar_amount)
    @sugar_water.sugar += sugar_amount
  end

  # 水を加える
  def add_water(water_amount)
    @sugar_water.water += water_amount
  end

  # 砂糖水の状態を返す
  def result
    @sugar_water
  end
end

# Director： 砂糖水の作成過程を取り決める
class Director
  def initialize(builder)
    @builder = builder
  end
  def cook
    @builder.add_water(150)
    @builder.add_sugar(90)
    @builder.add_water(300)
    @builder.add_sugar(35)
  end
end

# ===========================================
builder = SugarWaterBuilder.new
director = Director.new(builder)
director.cook

p builder.result
#=> #<SugarWater:0x007fc773085bc8 @water=450, @sugar=125>

