# Add a class method to your MyCar class that calculates the gas mileage of any car.

class MyCar
  attr_reader :year
  attr_accessor :color, :speed
  
  def initialize(year, color, model)
    @year  = year
    @color = color
    @model = model
    @speed = 0
  end
  
  def self.mileage_calc(mpg, gallons)
    puts "This car could travel #{mpg.to * gallons} miles on this fuel."
  end
  
  def speed_up(speed_increase)
    @speed += speed_increase
    puts "You have increased speed to #{self.speed}."
  end
  
  def brake(speed_decrease)
    @speed += speed_decrease
    puts "You have slowed down to #{self.speed}."
  end
  
  def shut_car_off
    @speed = 0
    puts "You have stopped the car. It is now stationary at #{self.speed}."
  end
  
  def spray_paint(color)
    color=(color)
  end
  
end

tom_car = MyCar.new(1981, "white", "Ford Focus")
p MyCar.mileage_calc(9,10)
