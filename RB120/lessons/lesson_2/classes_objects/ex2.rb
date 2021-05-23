# Modify the class definition from above to facilitate the following methods. 
# Note that there is no name= setter method now.


# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'
# Hint: let first_name and last_name be "states" and create an instance method called name that uses those states.


class Person
  attr_accessor :first_name, :last_name
  def initialize(first_name, last_name = "")
    @first_name = first_name
    @last_name = last_name
  end
  
  def name
    self.first_name + " " + self.last_name
  end
end


bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
p bob.last_name = 'Smith'
p bob.name 