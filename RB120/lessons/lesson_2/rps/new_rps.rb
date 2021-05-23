# the FUNCTIONALITY to compare one move object to another and output a result WIN/LOSS/TIE

module Moves
  include Comparable
  
  def ==(computer)
    if self.class == computer.class
      puts "It's a tie!"
    end
  end
  
  def >(computer)
    if beats.include?(computer.class)
      puts "Player wins!"
    end
  end
  
  # def <(computer)
  #   if 
  # end
end
  
  # Here I want to be able to compare a human caller with a computer argument and display a winner.
  # If caller class IS SAME as argument class THIS IS A TIE
  # If caller the caller BEATS ARRAY contains the computer argument class then PLAYER WINS
  # ELSE computer wins
  # puts "It is a TIE!"
  #   elsif name > computer
  #     self.beats.include?(computer.class) == true
  #   end
    
 
class Rock
  include Moves
  attr_reader :beats, :name
  
  def initialize
    @beats = %w(Scissors Lizard)
    @name = "Rock"
  end
  # implicit rules stored in each object about object this class "beats".
end

class Paper
  include Moves
  attr_reader :beats, :name
  
  def initialize
    @beats = %w(Rock Spock)
    @name = "Paper"
  end
  # implicit rules stored in each object about object this class "beats".
end
  
class Scissors
  include Moves
  attr_reader :beats, :name
  
  def initialize
    @beats = %w(Paper Lizard)
    @name = "Scissors"
  end
  # implicit rules stored in each object about object this class "beats".
end
  
class Lizard
  include Moves
  attr_reader :beats, :name
  
  def initialize
    @beats = %w(Paper Spock)
    @name = "Lizard"
  end
  # implicit rules stored in each object about object this class "beats".
end
  
class Spock
  include Moves
  attr_reader :beats, :name
  
  def initialize
    @beats = %w(Rock Scissors)
    @name = "Spock"
  end
  # implicit rules stored in each object about object this class "beats".
end

class Player
   def initialize
    @current_move = nil
    @name = nil
  end
  
  def name=(name)
    @name = name
  end
  
  def current_move=(move)
    @current_move = move
  end
  
  def choose_name
    choose_name
  end
  
  def choose_move
    choose_move
  end
  # has a current move stored
  # has a score
  # has a history of moves
  # has fully selection of move objects to pick from (Rock, Paper, Scissors, Lizard, Spock)
end
  

class Human < Player
  
  # def initialize
  #   @current_move = nil
  #   @name = nil
  # end
  
  def welcome_message
    puts "Hey fools! Welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts "Follow the instructions and have fun! :-)"
  end
  
  def choose_name
    puts "Please enter your NAME for the game RPSLS: "
    user_name = gets.chomp
    self.name=(user_name)
  end
  
  def choose_move
    user_move = nil
    puts "Please enter a MOVE: "
    puts "Rock, Paper, Scissors, Lizard, Spock:"
    loop do
      user_move = gets.chomp
      break if %w(Rock Paper Scissors Lizard Spock).include?(user_move)
      puts "Wrong answer! Please type Rock, Paper, Scissors, Lizard, Spock."
    end
    
    move_object = case user_move
                  when "Rock"     then Rock.new
                  when "Paper"    then Paper.new
                  when "Scissors" then Scissors.new
                  when "Lizard"   then Lizard.new
                  when "Spock"    then Spock.new
                  end
    self.current_move=(move_object)
  end
  
  # def name=(name)
  #   @name = name
  # end
  
  # def current_move=(move)
  #   @current_move = move
  # end
  
  #TESTING FOR THE HUMAN INSTANCES IN ISOLATION
#   new_human = Human.new
# new_human.choose_name
# p new_human
# new_human.choose_move
# p new_human
end

class Computer < Player
  def initialize
    @possible_computer_names = %w(R2D2 HAL Johnny5 T1000 Ava)
    super
  end
  
  def possible_computer_names
    @possible_computer_names
  end
  
  # has an assigned computer name
  # has a computer personality (set of traits around likely moves)
  def choose_name
    current_name = possible_computer_names.sample
    self.name=(current_name)
  end
  
  def choose_move
    # randomly choosen
  end
end

# LEAVE ENGINE TO END. 
# I CAN ADD IN THE LINES BELOW IN CORRECT ORDER THEN.

# class GameEngine
#   new_human = Human.new
#   new_human.welcome_message
#   new_human.choose_move
#   new_human.play
# end

# GameEngine.new

# human welcome, name, turn
  # new_human = Human.new
  # new_human.welcome_message
  # new_human.choose_name
  # new_human.choose_move
  # p new_human
  # all of human actions ABOVE are WORKING

# computer name, turn
# new_computer = Computer.new
# new_computer.choose_name
# new_computer.choose_move
# p new_computer
 # all of computer actions ABOVE are WORKING
  
  # compare moves
  # decide winner
  # display winner as a string

  rock1 = Rock.new
  p rock1
  rock2 = Rock.new
  p rock2
  
  paper1 = Paper.new
  p paper1
  
  if rock1.class == rock2.class
    puts "It's a tie!"
  end
  if rock1 > paper1
    puts "Caller wins 'Rock'"
  end