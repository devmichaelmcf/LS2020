# Update this code so that when you run it, you see the following output:

# My cat Pudding is 7 years old and has black and white fur.
# My cat Butterscotch is 10 years old and has tan and white fur.

class Pet
  attr_reader :name, :age, :color
  
  def initialize(name, age, color)
    @name = name
    @age = age
    @color = color
  end
  
  def to_s
    "My #{self.class.to_s.downcase} #{name} is #{age} years old and has #{color} fur."
  end
end

class Cat < Pet
end

class Dog < Pet
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

doggy = Dog.new("Rex", 12, "grey")
puts doggy