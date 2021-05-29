# Using the following code, add an instance method named #rename that renames kitty when invoked.

# Expected output:

# Sophie
# Chloe

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def rename(name)
    self.name=(name)
  end
end

p kitty = Cat.new('Sophie')
p kitty.name
p kitty.rename('Chloe')
p kitty.name