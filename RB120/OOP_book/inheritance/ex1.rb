# Create a superclass called Vehicle for your MyCar class to inherit from and move the behavior that isn't specific 
# to the MyCar class to the superclass. 
# Create a constant in your MyCar class that stores information about the vehicle that makes it different from 
# other types of Vehicles.

# Then create a new class called MyTruck that inherits from your superclass that also has a constant defined that 
# separates it from the MyCar class in some way.

class Vehicle
  attr_accessor :color, :speed, :year
  
  def initialize(year, color, model)
    @year  = year
    @color = color
    @model = model
    @speed = 0
  end
  
  def self.mileage_calc(mpg, gallons)
    puts "This #{self.vehicle_type} could travel #{mpg * gallons} miles on this fuel."
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
    puts "You have stopped the #{self.vehicle_type}. It is now stationary at #{self.speed}."
  end
  
  def spray_paint(color)
    self.color=(color)
  end

  def num_doors
    DOORS
  end
  
  def business_use?
    BUSINESS_USE
  end
  
  def vehicle_type
    VEHICLE
  end
  
end

class MyCar < Vehicle
  
  DOORS = 4
  BUSINESS_USE = false
  VEHICLE = "car"
  
  def num_doors
    DOORS
  end
  
  def business_use?
    BUSINESS_USE
  end
  
  def vehicle_type
    VEHICLE
  end
end


class MyTruck < Vehicle

  DOORS = 2
  BUSINESS_USE = true
  VEHICLE = "truck"
  
  def num_doors
    DOORS
  end
  
  def business_use?
    BUSINESS_USE
  end
  
  def vehicle_type
    VEHICLE
  end 
end

new_car = MyCar.new(1981, "yellow", "Astra")
new_truck = MyTruck.new(2003, "white", "Sprint")
p new_truck.num_doors
p new_truck.speed_up(10)
p new_truck.speed
p new_truck.shut_car_off
p new_truck.color
new_truck.spray_paint("black")
p new_truck.color


p new_car.num_doors
p new_car.speed_up(99)
p new_car.speed
p new_car.shut_car_off
p new_car.color
new_car.spray_paint("green")
p new_car.color

