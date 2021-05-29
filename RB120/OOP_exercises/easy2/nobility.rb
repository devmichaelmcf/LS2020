# Now that we have a Walkable module, we are given a new challenge. 
# Apparently some of our users are nobility, and the regular way of walking
# simply isn't good enough. Nobility need to strut.

# We need a new class Noble that shows the title and name when walk is called:

module Walkable
  def walk
    puts "#{self.name} #{gait} forward"
  end
end

class Person
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Noble < Person
  attr_reader :name, :title
  def initialize(name, title)
    super(name)
    @title = title
  end
  
  def walk  #walkable module NOT included so use duck typing due to diff implementation.
    puts "#{self.title} #{self.name} #{gait} forward"
  end
  
  private

  def gait
    "struts"
  end
end

class Cat
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah < Cat
  def initialize(name)
    super
  end

  private

  def gait
    "runs"
  end
end


byron = Noble.new("Byron", "Lord")
byron.walk
# => "Lord Byron struts forward"

# We must have access to both name and title because they are needed for other 
# purposes that we aren't showing here.

p byron.name
#=> "Byron"
p byron.title
#=> "Lord"

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"