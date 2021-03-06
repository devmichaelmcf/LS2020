require "pry"

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals
  
  def initialize
    @squares = {}
    reset
  end
  
  def reset
    (1..9).each {|key| @squares[key] = Square.new }
  end
  
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
    puts ""
  end
  
  # This method removed entirely becuase we are access instance variables hash @squares directly.
  
  # def get_square_at(key)
  #   @squares[key]  # remember this returns a SQUARE OBJECT
  # end
  
  def []=(key, marker)
    @squares[key].marker = marker
  end
  
  def unmarked_keys
    @squares.keys.select {|key| @squares[key].unmarked? }
  end
  
  def full?
    unmarked_keys.empty?
  end
  
  def someone_won?
    !!winning_marker
  end
  
  # def count_human_marker(squares)
  #   squares.collect(&:marker).count(TTTGame::HUMAN_MARKER)
  # end
  
  # def count_computer_marker(squares)
  #   squares.collect(&:marker).count(TTTGame::COMPUTER_MARKER)
  # end
  
  # def three_identical_markers(squares)
  #   markers = squares.select(&:marked?).collect(&:marker)
  #   return false if markers.size != 3
  #   markers.min == markers.max
  # end
  
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end
  
  #returns winning marker or nil
  # def winning_marker
  #   WINNING_LINES.each do |line|
  #     if count_human_marker(@squares.values_at(*line)) == 3
  #       return TTTGame::HUMAN_MARKER
  #     elsif count_computer_marker(@squares.values_at(*line)) == 3
  #       return TTTGame::COMPUTER_MARKER
  #     end
  #   end
  #   nil
  # end
  
  # below is refactoring of above method
  
  # def winning_marker
  #   WINNING_LINES.each do |line|
  #     if line.all?(line[0])
  #       return line[0]
  #     end
  #   end
  #   nil
  # end
  
  private
  
  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "
  
  attr_accessor :marker
  
  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end
  
  def to_s
    @marker
  end
  
  def unmarked?
    @marker == INITIAL_MARKER
  end
  
  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker
  
  def initialize(marker)
    @marker = marker
  end

end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  
  attr_reader :board, :human, :computer, :current_player
  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @first_to_move = @computer
    @current_player = @first_to_move
  end
  
  def play
    clear
    
    display_welcome_message
    
    loop do
      display_board
      
        loop do
          current_player_moves
          break if board.someone_won? || board.full?
          swap_current_player_turn
          clear_screen_and_display_board if human_turn?
        end
      
      display_result
      break unless play_again?
      reset
      reset_current_player_to_human    # resets starting player to HUMAN first.
      display_play_again_message
    end
    
    display_goodbye_message
  end
  
  private
  
  def clear
    system 'clear'
  end
  
  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end
  
  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end
  
  def clear_screen_and_display_board
    clear
    display_board
  end
  
  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end  
  
  def human_moves
    puts "Choose a square between (#{board.unmarked_keys.join(", ")}):"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end 
    
    board.[]=(square, human.marker)
  end
  
  def computer_moves
    board.[]=(board.unmarked_keys.sample, computer.marker)
  end
  
  def current_player_moves
    @current_player == @human ? human_moves : computer_moves
  end
  
  def human_turn?
    @current_player == @human
  end
  
  def computer_turn?
    @current_player == @computer
  end
  
  def display_result
    clear_screen_and_display_board
    
    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end
  
  def reset
    board.reset         # remember TTT#reset and Board#reset different methods.
    clear
  end
  
  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
  
  def reset_current_player_to_human
    @current_player = @human
  end
  
  def swap_current_player_turn
    if @current_player == @human
      @current_player = @computer
    else
      @current_player = @human
    end
  end
  
  def play_again?
    answer = nil
    
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y or n"
    end
    
    answer == 'y'
  end
  
  # def play
  #   clear
    
  #   display_welcome_message
    
  #   loop do
  #     display_board
      
  #       loop do
  #         current_player_moves
  #         break if board.someone_won? || board.full?
  #         swap_current_player_turn
  #         clear_screen_and_display_board if human_turn?
  #       end
      
  #     display_result
  #     break unless play_again?
  #     reset
  #     reset_current_player_to_human
  #     display_play_again_message
  #   end
    
  #   display_goodbye_message
  # end
end

game = TTTGame.new
game.play