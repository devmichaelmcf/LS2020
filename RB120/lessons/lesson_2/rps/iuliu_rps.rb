require "pry"

class Move
  include Comparable

  attr_accessor :value
  
  VALUES = %w(rock paper scissors lizard spock)

  def <=>(other_move)
    return  0 if value == other_move.value
    return  1 if @beats.include? other_move.value 
    return -1 if @loses.include? other_move.value
  end
end

class Rock < Move
  def initialize
    @value = "rock"
    @beats = ["scissors", "lizard"]
    @loses = ["paper", "spock"]
  end
end

class Paper < Move
  def initialize
    @value = "paper"
    @beats = ["rock", "spock"]
    @loses = ["scissors", "lizard"]
  end
end

class Scissors < Move
  def initialize
    @value = "scissors"
    @beats = ["paper", "lizard"]
    @loses = ["rock", "spock"]
  end
end

class Lizard < Move 
  def initialize
    @value = "lizard"
    @beats = ["spock", "paper"]
    @loses = ["scissors", "rock"]
  end
end

class Spock < Move
  def initialize
    @value = "spock"
    @beats = ["rock", "scissors"]
    @loses = ["paper", "lizard"]
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
  
  def add_win
    self.score += 1    
  end
  
  def ten_wins?
    self.score >= 10
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, spock or lizard:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['RSD2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer

  
  def initialize
    @human = Human.new
    @computer = Computer.new
  end
  
  def grand_winner?
    human.ten_wins? || computer.ten_wins?
  end
  
  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Spock, Lizard. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
      human.add_win
    elsif human.move < computer.move
      puts "#{computer.name} won!"
      computer.add_win
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "#{human.name}: #{human.score} - #{computer.name}: #{computer.score}"
    if human.ten_wins? 
      puts "#{human.name} is the GRAND WINNER with #{human.score} wins!"
    elsif computer.ten_wins?
      puts "#{computer.name} is the GRAND WINNER with #{computer.score} wins!"
    end
  end
  
  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end

    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      display_score
      break if grand_winner?
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
