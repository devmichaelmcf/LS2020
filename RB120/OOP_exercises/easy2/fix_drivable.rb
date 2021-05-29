# Correct the following program so it will work properly. 
# Assume that the Car class has a complete implementation; just make the smallest possible change to 
# ensure that cars have access to the drive method.


module Drivable
  def drive
    puts "Hey, drive works! I changed it from a class method to an instance method!"
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive