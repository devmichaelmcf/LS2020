module Printable
        def print_pets_arr(pet_arr)
          pet_arr.each do |pet_object|
            puts "a #{pet_object.pet_type} called #{pet_object.pet_name}"
          end
        end
end


class Pet
  attr_reader :pet_type, :pet_name
  
  def initialize(pet_type, pet_name)
    @pet_type = pet_type
    @pet_name = pet_name
  end
end


class Owner
  include Printable
  attr_reader :name, :pets_arr
  
  def initialize(name)
    @name = name
    @pets_arr = []
  end
  
  def number_of_pets
    pets_arr.length
  end
  
  def print_pets
    puts "#{name.to_s.capitalize} owns the following pets: "
    print_pets_arr(pets_arr)
  end
end


class Shelter
  include Printable
  attr_accessor :records_hash , :available_pets
  def initialize
    @records_hash = {}
    @available_pets = []
  end
  
  def number_of_pets_at_shelter
    available_pets.length
  end
  
  def give_pet_to_shelter(pet_object)
    available_pets << pet_object
  end
  
  def adopt(owner_name,pet_name)
    owner_name.pets_arr << pet_name  #this adds pet to the owner pets_arr
    
    if records_hash[owner_name].nil?
      records_hash[owner_name] = [pet_name]
    else
      records_hash[owner_name] << pet_name
    end
  end
  
  def print_pets
    puts "The Animal Shelter has the following unadopted pets:"
    print_pets_arr(available_pets)
  end
  
  def print_adoptions
    records_hash.each do |human, pet_arr|
      puts "#{human.name} has adopted the following pets:"
      print_pets_arr(pet_arr)
    end
    puts ""
  end
  
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

 shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions  
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

puts ""
puts "--------FURTHER EXPLORATION------------"
# Add your own name and pets to this project.

# Suppose the shelter has a number of not-yet-adopted pets, and wants to manage them through this same system. Thus, you should be able to add the following output to the example output shown above:

asta        = Pet.new('dog', 'Asta')
laddie      = Pet.new('dog', 'Laddie')
fluffy      = Pet.new('cat', 'Fluffy')
kat         = Pet.new('cat', 'Kat')
ben         = Pet.new('cat', 'Ben')
chatterbox  = Pet.new('parakeet', 'Chatterbox')
bluebell    = Pet.new('parakeet', 'Bluebell')

arr_of_pets = [asta, laddie, fluffy, kat, ben, chatterbox, bluebell]

arr_of_pets.each do |pet_object|
  shelter.give_pet_to_shelter(pet_object)
end

shelter.give_pet_to_shelter(Pet.new("dragon","Viserion"))   
shelter.print_pets
puts ""
puts "The Animal Shelter has #{shelter.number_of_pets_at_shelter} unadopted pets."
puts "----------------------------------------"
michael = Owner.new("Michael")
shelter.adopt(michael,shelter.available_pets.pop)

michael.print_pets
puts ""
puts "The Animal Shelter has #{shelter.number_of_pets_at_shelter} unadopted pets."
