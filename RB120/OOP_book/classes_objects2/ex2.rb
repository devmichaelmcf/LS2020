#Override the to_s method to create a user friendly print out of your object.

class MyCar
  attr_reader :year
  attr_accessor :color, :speed
  
  def initialize(year, color, model)
    @year  = year
    @color = color
    @model = model
    @speed = 0
  end
  
  def to_s
    "Hi my car is from #{self.year}, the color #{self.color} and travelling at #{self.speed} mph."
  end
  
  def self.mileage_calc(mpg, gallons)
    puts "This car could travel #{mpg * gallons} miles on this fuel."
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
puts tom_car
tom_car.speed_up(10)
puts tom_car
MyCar.mileage_calc(9,10)
