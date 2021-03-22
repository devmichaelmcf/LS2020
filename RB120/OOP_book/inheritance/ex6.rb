# Write a method called age that calls a private method to calculate the age of the vehicle. 
# Make sure the private method is not available from outside of the class. 
# You'll need to use Ruby's built-in Time class to help.

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
    @speed -= speed_decrease
    puts "You have slowed down to #{self.speed}."
  end
  
  def shut_off
    @speed = 0
    puts "You have stopped the #{self.vehicle_type}. It is now stationary at #{self.speed}."
  end
  
  def spray_paint(color)
    self.color=(color)
  end
  
   def age_public
    "This #{self.vehicle_type} is #{Time.new.year - date_made_private} years old!"
  end
  
  private 
  
  def date_made_private
    self.year
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

car1 = MyCar.new(1981, "green", "Mondeo")
truck1 = MyTruck.new(2004, "white", "BMW Hybrid" )

p car1.age_public       # public method using private method in implementation
p truck1.age_public     # public method using private method in implementation

p car1.date_made_private    # Raises exception because private method
# p truck1.date_made_prvate   # Raises exception because private method