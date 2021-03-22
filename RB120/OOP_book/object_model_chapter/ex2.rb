# What is a module? What is its purpose? How do we use them with our classes? 
# Create a module for the class you created in exercise 1 and include it properly.

# Answer
# ------
# A module is a way to achieve polymorphism. It allows us to reuse behaviors (instance methods) from other classes
# and allows us to follow DRY principles (Don'r repeat yourself).
module Shoutable
end

class MichaelClass
  @vocabulary = "Woooot!!!"
  
  include Shoutable
end


my_object = MichaelClass.new
puts MichaelClass.ancestors