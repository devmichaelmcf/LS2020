require "pry"

class Logger
  attr_reader :record
  
  def initialize
    @record = []
    @move_number = 1
  end
  
  def add_to_log(human_obj, computer_obj)
    record << "Move number: #{@move_number}"
    record << "#{human_obj.name} chose #{human_obj.move}."
    record << "#{computer_obj.name} chose #{computer_obj.move}."
    record << "#{human_obj.name}: #{human_obj.score} - #{computer_obj.name}: #{computer_obj.score}"
    record << "-------------------------------------"
    @move_number += 1
  end
  
  
  def print
    record.each {|line| puts line }
  end
end


class Move
  attr_accessor :choice 
  
  def initialize(choice)
    @choice = choice     # string e.g. "rock", or "paper" etc. Same as player move parameter.
  end
  
  VALUES = %w(rock paper scissors lizard spock)
  HIGH_SCISSORS_NO_PAPER_RARE_ROCK_VALUES = %w(rock scissors scissors scissors scissors scissors scissors scissors 
  scissors scissors scissors scissors scissors lizard lizard lizard lizard spock spock spock spock)
  SLIGHTLY_MORE_PAPER_VALUES = %w(rock paper paper scissors lizard spock)
  LIZARD_SPOCK_ONLY_VALUES = %w( lizard spock)
  
  def >(other_choice)
    beats.include?(other_choice)
  end
  
  def to_s
    "#{choice}"
  end
end

class Rock < Move
  def beats 
    ["scissors", "lizard"]
  end
end

class Paper < Move
  def beats
    ["rock", "spock"]
  end
end

class Scissors < Move
  def beats
    ["paper", "lizard"]
  end
end

class Lizard < Move 
  def beats
    ["spock", "paper"]
  end
end

class Spock < Move
  def beats
    ["rock", "scissors"]
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
  
  def get_move(move)
    case move
    when "rock"     then Rock.new(move)
    when "paper"    then Paper.new(move)
    when "scissors" then Scissors.new(move)
    when "lizard"   then Lizard.new(move)
    when "spock"    then Spock.new(move)
    end
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
    move = nil
    loop do
      puts "Please choose rock, paper, scissors, spock or lizard:"
      move = gets.chomp.downcase
      break if Move::VALUES.include?(move)
      puts "Sorry, invalid choice."
    end
    self.move = get_move(move)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample    # ADD TO ARRAY USED FOR TESTING:   , 'Hal', 'Chappie', 'Sonny', 'Number 5'
  end

  def choose
    if self.name == "R2D2"        # always chooses rock
      self.move = get_move("rock")
    elsif self.name == "Hal"      # mostly chooses scissors, never paper, rarely rock
      self.move = get_move(Move::HIGH_SCISSORS_NO_PAPER_RARE_ROCK_VALUES.sample)
    elsif self.name =="Chappie"   # all values but more often paper choosen
      self.move = get_move(Move::SLIGHTLY_MORE_PAPER_VALUES.sample)
    elsif self.name == "Sonny"    # only chooses from spock or lizard choices
      self.move = get_move(Move::LIZARD_SPOCK_ONLY_VALUES.sample)
    else                          # Number 5's choice perfectly random between choices
      self.move = get_move(Move::VALUES.sample)
    end
  end
end

class RPSGame
  attr_accessor :human, :computer, :log

  def initialize
    @human = Human.new
    @computer = Computer.new
    @log = Logger.new
  end
  
  # def add_to_log
  #   log.record << "#{human.name} chose #{human.move}."
  #   log.record << "#{computer.name} chose #{computer.move}."
  #   log.record << "#{human.name}: #{human.score} - #{computer.name}: #{computer.score}"
  # end
  
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
    p human.move
    p computer.move
    if human.move > computer.move.choice
      puts "#{human.name} won!"
      human.add_win
    elsif computer.move > human.move.choice
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
  
  def log_moves
    log.add_to_log(human, computer)
  end
  
  def print_log
    log.print    # so i need a print method in log class now
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_moves
      log_moves # this is different implementation to make format a bit nicer for actual METHOD: log.add_to_log(human, computer)
      # log.add_to_log(human, computer)
      display_winner
      display_score
      break if grand_winner?
      break unless play_again?
    end
    display_goodbye_message
    print_log
    
    #p log
  end
  
end

# class Logger
#   attr_reader :record
  
#   def initialize
#     @record = []
#   end
  
#   def add_to_log
#     record << "#{human.name} chose #{human.move}."
#     record << "#{computer.name} chose #{computer.move}."
#     record << "#{human.name}: #{human.score} - #{computer.name}: #{computer.score}"
#   end
# end

RPSGame.new.play