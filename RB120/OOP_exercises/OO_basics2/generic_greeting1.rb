# Modify the following code so that Hello! I'm a cat! is printed when Cat.generic_greeting is invoked.

# Expected output:

# Hello! I'm a cat!

# ********************
# Further Exploration
# What happens if you run kitty.class.generic_greeting? Can you explain this result?
# 
# I suspect it will be the SAME output as before with Cat.generic_greeting.
# This is because we are calling the class instance method #class on the kitty object. This returns a class object
# Cat. Then the class method ::generic_greeting is called on the Cat class object.

# Correct but I forgot to create a new instance of the Cat class called kitty.


class Cat
  def self.generic_greeting
    puts "Hello I'm a cat!"
  end
end

Cat.generic_greeting
kitty = Cat.new
kitty.class.generic_greeting