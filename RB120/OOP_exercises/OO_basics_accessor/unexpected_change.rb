# Modify the following code to accept a string containing a first and last name. 
# The name should be split into two instance variables in the setter method, 
# then joined in the getter method to form a full name.

# Expected output:

# John Doe

class Person
  
  def name=(full_name)
    @first_name , @second_name = full_name.split
  end
  
  def name
    @first_name + " " + @second_name
  end
  
  private
  
  attr_accessor :first_name, :second_name
end

person1 = Person.new
person1.name = 'John Doe'
p person1
puts person1.name