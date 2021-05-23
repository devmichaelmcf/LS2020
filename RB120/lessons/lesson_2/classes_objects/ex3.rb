# Now create a smart name= method that can take just a first name or a full name, 
# and knows how to set the first_name and last_name appropriately.
class Person
  attr_accessor :first_name, :last_name
  def initialize(first_name, last_name = "")
    @first_name = first_name
    @last_name = last_name
  end
  
  def name=(full_name)
    arr_names = full_name.split
    self.first_name=(arr_names.first)
    self.last_name=(arr_names.last)
  end
  
  def name
    if last_name.empty?
      self.first_name
    else
      self.first_name + " " + self.last_name
    end
  end
end


p bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
p bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

p bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'