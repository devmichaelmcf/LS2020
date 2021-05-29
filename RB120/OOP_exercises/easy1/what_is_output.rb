=begin
Take a look at the following code:
What output does this code print? 
Fix this class so that there are no surprises waiting in store for the unsuspecting developer.

My thoughts BEFORE viewing solution (HAVE viewed output) are:
1) First fluffy.name does NOT need to use #to_s method because the intialize
method uses the default basic object #to_s and not out customer #to_s.
2) puts fluffy DOES use out custom #to_s method so it mutates @name then outputs the string sentence.
3) puts fluffy.name DOES not use our custom #to_s method. I presume this is because Ruby realises it is 
ALREADY a string. Therefore we get FLUFFY
4) I have no clue why puts name returns FLUFFY. I'm confused because it appears we are calling the local
variable name. But on line 5 @name is being disconnected from the name argument passed in to the intialize
method. @name = name.to_S returns a NEW STRING. SO i don't know why the name local
variable would be mutated.
=end

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
puts "----------------"
name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name