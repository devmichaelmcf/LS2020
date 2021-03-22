# When running the following code...
# test.rb:9:in `<main>': undefined method `name=' for
#   #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)
# Why do we get this error and how do we fix it?

# ANSWER we fix it by creating a setter method by changing attr_reader TO attr_writer (since we do not need a getter).

class Person
  attr_writer :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
p bob
bob.name = "Bob"
p bob