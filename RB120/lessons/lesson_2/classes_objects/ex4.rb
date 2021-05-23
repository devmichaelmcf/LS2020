# Using the class definition from step #3, let's create a few more people -- that is, Person objects.

# bob = Person.new('Robert Smith')
# rob = Person.new('Robert Smith')

# If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?


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
end

p bob = Person.new('Robert Smith')
p rob = Person.new('Robert Smith')
p rob == rob