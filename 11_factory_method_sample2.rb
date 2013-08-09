# -*- coding: utf-8 -*-

# サックス (Product)
class Saxophone
  def initialize(name)
    @name = name
  end

  def play
    puts "サックス #{@name} は音を奏でています"
  end
end

# トランペット (Product)
class Trumpet
  def initialize(name)
    @name = name
  end

  def play
    puts "トランペット #{@name} は音を奏でています"
  end
end

# 楽器工場 (Creator)
class InstrumentFactory
  def initialize(number_instruments)
    @instruments = []
    number_instruments.times do |i|
      instrument = new_instrument("楽器 #{i}")
      @instruments << instrument
    end
  end

	# 楽器を出荷する
	def ship_out
		tmp = @instruments.dup
		@instruments = []
		tmp
	end
end

# SaxophoneFactory: サックスを生成する (ConcreteCreator)
class SaxophoneFactory < InstrumentFactory
  def new_instrument(name)
    Saxophone.new(name)
  end
end

# TrumpetFactory: トランペットを生成する (ConcreteCreator)
class TrumpetFactory < InstrumentFactory
  def new_instrument(name)
    Trumpet.new(name)
  end
end

# ===========================================
factory = SaxophoneFactory.new(3)
saxophones = factory.ship_out
saxophones.each { |saxophone| saxophone.play }  
#=> サックス 楽器 0 は音を奏でています
#=> サックス 楽器 1 は音を奏でています
#=> サックス 楽器 2 は音を奏でています

factory = TrumpetFactory.new(2)
trumpets = factory.ship_out
trumpets.each { |trumpet| trumpet.play }  
#=> トランペット 楽器 0 は音を奏でています
#=> トランペット 楽器 1 は音を奏でています
