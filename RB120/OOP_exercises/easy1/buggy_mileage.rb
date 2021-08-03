# Fix the following code so it works properly:

class Car
  attr_accessor :mileage, :total

  def initialize
    @mileage = 0
    @total = 0
  end

  def increment_mileage(miles)
    self.total = mileage + miles
    self.mileage = total
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678