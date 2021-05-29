# Create a new class called Cat, which can do everything a dog can, except swim or fetch. 
# Assume the methods do the exact same thing. 
# Hint: don't just copy and paste all methods in Dog into Cat; try to come up with some class hierarchy.
class Mammal

  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Mammal
  
  def speak
    'bark!'
  end
  
  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Mammal
  
  def speak
    "meow!"
  end 
end

class BullDog < Dog
  def swim
    "Cannot swim!"
  end
end

cat1 = Cat.new
dog1 = Dog.new
bulldog1 = BullDog.new

p cat1
p dog1
puts "-------cat1-------"
p cat1.speak
p cat1.jump
p cat1.run
puts "-------dog1-------"
p dog1.speak
p dog1.fetch
p dog1.swim
puts "-----bulldog1-----"
p bulldog1.speak
p bulldog1.fetch
p bulldog1.swim