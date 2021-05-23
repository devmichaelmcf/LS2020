# Continuing with our Person class definition, what does the below print out?

# Copy Code
# bob = Person.new("Robert Smith")
# puts "The person's name is: #{bob}"
# *********************************
# ANSWER: This code I believe would output the sentence "The person's name is: OBJECT MEMORY ADDRESS"

# SECOND QUESTION BELOW:
# Let's add a to_s method to the class:

# Copy Code
# class Person
#   # ... rest of class omitted for brevity

#   def to_s
#     name
#   end
# end

# ANSWER: It prints out "The person's name is Robert Smith" because the #to_s method 
# is overridden and automatically called on the object with string interpolation.

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
  
  def ==(other_person)
    (first_name + last_name) == (other_person.first_name + other_person.last_name)
  end
  
  def to_s
    name
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
