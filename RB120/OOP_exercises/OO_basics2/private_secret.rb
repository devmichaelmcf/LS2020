# Using the following code, add a method named share_secret that prints the value of @secret when invoked.

# Expected output:

# Shh.. this is a secret!

class Person
  attr_writer :secret
  
  public 
  
  def share_secret
    secret
  end

  private

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
p person1.share_secret