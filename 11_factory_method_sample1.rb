# -*- coding: utf-8 -*-

# サックス (Product)
class Saxophone
  def initialize(name)
    @name = name
  end

  def play
    puts "#{@name} は音を奏でています"
  end
end

# 楽器工場 (Creator)
class InstrumentFactory
  def initialize(number_saxophones)
    @saxophones = []
    number_saxophones.times do |i|
      saxophone = Saxophone.new("サックス #{i}")
      @saxophones << saxophone
    end
  end

	# 楽器を出荷する
	def ship_out
		tmp = @saxophones.dup
		@saxophones = []
		tmp
	end
end

# ===========================================
factory = InstrumentFactory.new(3)
saxophones = factory.ship_out
saxophones.each { |saxophone| saxophone.play }  
#=> サックス 0 は音を奏でています
#=> サックス 1 は音を奏でています
#=> サックス 2 は音を奏でています
