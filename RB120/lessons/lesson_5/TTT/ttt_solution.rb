require "pry"

class Board
  attr_accessor :squares
  
  JOINER_DELIMITER = ","
  JOINER_WORD = "or"
  
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def joiner
    case unmarked_keys.length
      when 1 then unmarked_keys.join(" ")
      when 2 then unmarked_keys.join(" #{JOINER_WORD} ")
    else
      unmarked_keys[0..-3].join(", ") + ", " + unmarked_keys[-2..-1].join("#{JOINER_DELIMITER} #{JOINER_WORD} ")
    end
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end
  
  # still to edit below
  def two_human_marker_and_space_location
    WINNING_LINES.each do |line|     # subarray of winning integer keys
      squares = @squares.values_at(*line)   # array is SQUARE OBJECT I think
      if two_human_marker_and_space_potential_win?(squares)
        # the square key (from line that has space)
        line.each {|index| return index if @squares[index].marker == " " }
      end
    end
    nil
  end
  
  
  def two_human_marker_and_space_potential_win?(three_squares)
    markers = squares.values_at(*three_squares)#.map {|sq_object| sq_object.marker}
    (markers.count {|sq_obj| sq_obj.marker == TTTGame::HUMAN_MARKER } == 2) && (markers.count {|sq_obj| sq_obj.marker == TTTGame::INITIAL_MARKER } == 1)
  end

  def two_computer_marker_and_space_potential_win?(three_squares)
    markers = squares.values_at(*three_squares)#.map {|sq_object| sq_object.marker}
    (markers.count {|sq_obj| sq_obj.marker == TTTGame::COMPUTER_MARKER } == 2) && (markers.count {|sq_obj| sq_obj.marker == TTTGame::INITIAL_MARKER } == 1)
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
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
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

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
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker
  attr_accessor :total_wins

  def initialize(marker)
    @marker = marker
    @total_wins = 0
  end
  
  def add_win
    @total_wins += 1
  end
  
  def five_wins?
    @total_wins == 5
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  INITIAL_MARKER = " "
  FIRST_TO_MOVE = HUMAN_MARKER

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
  end

  def play
    clear
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def main_game
    loop do
      display_board
      player_moves
      display_result
      display_total_wins_for_each_player
      break display_grand_winner if five_total_wins?
      break unless play_again?
      reset
      display_play_again_message
    end
  end
  
  def five_total_wins?
    human.five_wins? || computer.five_wins?
  end

  def player_moves
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
    add_win_to_winning_player_total
  end

  def display_grand_winner
    if human.five_wins?
      puts "You and humanity wins the game with FIVE WINS!!!! Well done!"
    else computer.five_wins?
      puts "Sadly YOU LOSE! The computer wins the game with FIVE WINS!!!! Better luck next time!"
    end
  end
  
  def display_total_wins_for_each_player
    puts "Human has #{human.total_wins} wins, Computer has #{computer.total_wins} wins!"
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

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end
  

  def human_moves
    puts "Choose a square (#{board.joiner}): "
    
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    Board::WINNING_LINES.each do |three_winning_keys| 
      if board.two_human_marker_and_space_potential_win?(three_winning_keys)
        empty_sq_obj = board.squares.values_at(*three_winning_keys).select {|sq_obj| sq_obj.marker == TTTGame::INITIAL_MARKER }
        empty_sq_obj.first.marker = TTTGame::COMPUTER_MARKER
        return       # returns from method once marked an "AT DANGER" square with a COMPUTER MARKER
      end
   end
    
    board[board.unmarked_keys.sample] = computer.marker          # randomly chooses if no winning square found among all winning lines iterations.
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end
  
  def add_win_to_winning_player_total
    # act on each player when won
    case board.winning_marker
    when human.marker
      human.add_win
    when computer.marker
      computer.add_win
    end
    nil
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

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def clear
    system "clear"
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new
game.play
