# Add a class variable to your superclass that can keep track of the number of objects created that inherit from
# the superclass. 
# Create a method to print out the value of this class variable as well.

class Vehicle
  attr_accessor :color, :speed, :year
  
  @@num_of_objects = 0
  
  def initialize(year, color, model)
    @@num_of_objects += 1
    @year  = year
    @color = color
    @model = model
    @speed = 0
  end
  
  def self.total_objects_created
    @@num_of_objects
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

p Vehicle.total_objects_created
new_car = MyCar.new(1981, "yellow", "Astra")
p Vehicle.total_objects_created
new_truck = MyTruck.new(2003, "white", "Sprint")
p Vehicle.total_objects_created