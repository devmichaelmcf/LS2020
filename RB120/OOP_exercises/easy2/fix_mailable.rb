# Correct the following program so it will work properly. 
# Assume that the Customer and Employee classes have complete implementations; just make the smallest 
# possible change to ensure that objects of both types have access to the print_address method.

module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  include Mailable
  attr_reader :name, :address, :city, :state, :zipcode
  
  def initialize(name, address, city, state, zipcode)
    @name = name
    @address = address
    @city = city
    @state = state
    @zipcode = zipcode
  end
end

class Employee
  include Mailable
  attr_reader :name, :address, :city, :state, :zipcode
  
  def initialize(name, address, city, state, zipcode)
    @name = name
    @address = address
    @city = city
    @state = state
    @zipcode = zipcode
  end
end

betty = Customer.new("Mike", "12 Alvin Drive", "Glasgow", "Scotland", "G1 3EG")
bob = Employee.new("Jim's Electric Ltd", "1 Rollox Industrial Park", "London", "England", "SW2 1ST")
betty.print_address
puts "-------------------------------"
bob.print_address