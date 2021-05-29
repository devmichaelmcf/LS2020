# Using the code from the previous exercise, add a setter method named #name. 
# Then, rename kitty to 'Luna' and invoke #greet again.

# Expected output:

# Hello! My name is Sophie!
# Hello! My name is Luna!

class Cat
  attr_writer :name
  
  def initialize(name)
    @name = name
  end
  
  def greet
    puts "Hi there #{@name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.name=("Luna")
kitty.greet