class Move
  VALUES = ["rock", "paper", "scissors", "lizard", "spock"]

  def initialize(value)
    @value = value
  end

  def scissors?
    self.to_s == 'scissors'
  end

  def rock?
    self.to_s == 'rock'
  end

  def paper?
    self.to_s == 'paper'
  end

  def lizard?
    self.to_s == 'lizard'
  end

  def spock?
    self.to_s == 'spock'
  end

  def rock_wins?(other_move)
    return true if other_move.scissors? || other_move.lizard?
    false
  end

  def paper_wins?(other_move)
    return true if other_move.rock? || other_move.spock?
    false
  end

  def scissors_wins?(other_move)
    return true if other_move.paper? || other_move.lizard?
    false
  end

  def lizard_wins?(other_move)
    return true if other_move.spock? || other_move.paper?
    false
  end

  def spock_wins?(other_move)
    return true if other_move.scissors? || other_move.rock?
    false
  end

  def rock_loses?(other_move)
    return true if other_move.spock? || other_move.paper?
    false
  end

  def paper_loses?(other_move)
    return true if other_move.scissors? || other_move.lizard?
    false
  end

  def scissors_loses?(other_move)
    return true if other_move.rock? || other_move.spock?
    false
  end

  def lizard_loses?(other_move)
    return true if other_move.rock? || other_move.scissors?
    false
  end

  def spock_loses?(other_move)
    return true if other_move.lizard? || other_move.paper?
    false
  end

  def >(other_move)
    (rock? && rock_wins?(other_move)) ||
      (paper? && paper_wins?(other_move)) ||
      (scissors? && scissors_wins?(other_move)) ||
      (spock? && spock_wins?(other_move)) ||
      (lizard? && lizard_wins?(other_move))
  end

  def <(other_move)
    (rock? && rock_loses?(other_move)) ||
      (paper? && paper_loses?(other_move)) ||
      (scissors? && scissors_loses?(other_move)) ||
      (spock? && spock_loses?(other_move)) ||
      (lizard? && lizard_loses?(other_move))
  end

  def to_s
    @value
  end
end

class Rock < Move
end

class Paper < Move
end

class Scissors < Move
end

class Lizard < Move
end

class Spock < Move
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
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
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
      break if grand_winner? || !play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
