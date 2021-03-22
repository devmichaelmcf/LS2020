# Print to the screen your method lookup for the classes that you have created.

module Hornable
  def blow_horn
    puts "BEEEEEEPPP!!!!"
  end
end

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
  include Hornable
  
  
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

p MyCar.ancestors
p MyTruck.ancestors