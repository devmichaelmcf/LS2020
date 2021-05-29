# Refactor these classes so they all use a common superclass, and inherit behavior as needed.

class Vehicle
  attr_reader :make, :model
  def initialize(make, model)
    @make = make
    @model = model
  end
  
  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle

  def wheels
    4
  end
end

class Motorcycle < Vehicle

  def wheels
    2
  end

end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
  
end

truck1 = Truck.new("Ford", "Sprinter", "3 tonnes")
puts truck1
p truck1
p truck1.wheels
p truck1.payload
puts "====================="
car1 = Car.new("Porsche", 911)
puts car1
p car1
p car1.wheels
puts "====================="
motorbike1 = Motorcycle.new("Harley", "Dyna Glide")
puts motorbike1
p motorbike1
p motorbike1.wheels