# Consider the following class definition:
# There is nothing technically incorrect about this class, 
# but the definition may lead to problems in the future. 
# How can this class be fixed to be resistant to future problems?

# MY ANSWER: I think the issue is we have TOO MUCH access to the @database_handle 
# instance varible. We have PUBLIC getters AND setters.

# Depending on how the rest of the program is built we might need ZERO access to the 
# database handle or at the very least ONLY a reader.

class Flight
  attr_reader :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end