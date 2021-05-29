# What will the following code print?

class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new   # Object location created and @data = "Hello"
puts Something.dupdata  # Class method called. Returns new object "ByeBye"
puts thing.dupdata      # Called on object. Does return "HelloHello" because the
# instance method dupdate acts like a getter even though none a technically formed.