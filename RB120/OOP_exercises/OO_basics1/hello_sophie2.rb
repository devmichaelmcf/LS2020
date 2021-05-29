# Using the code from the previous exercise, move the greeting from the #initialize method to an instance 
# method named #greet that prints a greeting when invoked.

# Expected output:

# Hello! My name is Sophie!

class Cat
  def initialize(name)
    @name = name
  end
  
  def greet
    puts "Hi there #{@name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet