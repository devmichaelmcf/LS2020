WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                 [1, 4, 7], [2, 5, 8], [3, 6, 9],
                 [1, 5, 9], [3, 5, 7]].freeze

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(arr, punc = ', ', last_word = 'or')
  if arr.length == 1
    "#{arr[0]}"
  elsif arr.length == 2
    "#{arr[0]} #{last_word}#{punc}#{arr[1]}"
  elsif arr.length >= 3
    "#{arr[0..-2].join(punc)}#{punc}#{last_word} #{arr[-1]}"
  end
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd)
  puts `clear`
  puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ''
  puts '     |     |'
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts '     |     |'
  puts '-----------------'
  puts '     |     |'
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts '     |     |'
  puts '-----------------'
  puts '     |     |'
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts '     |     |'
  puts ''
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def intialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt("Choose a square #{joinor(empty_squares(brd))}:")
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)

    prompt("Sorry, that's not a valid choice.")
  end
  brd[square] = PLAYER_MARKER
end

# rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
def computer_places_piece!(brd)
  square = nil

  # offense
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, COMPUTER_MARKER)
    break if square
  end

  # defense first
  unless square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  # choose square 5 if has INTIAL_MARKER = " "
  square ||= 5 if brd[5] == INITIAL_MARKER

  # just pick a square
  square ||= empty_squares(brd).sample

  brd[square] = COMPUTER_MARKER
end
# rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    return 'Player' if brd.values_at(*line).count(PLAYER_MARKER) == 3

    return 'Computer' if brd.values_at(*line).count(COMPUTER_MARKER) == 3
  end
  nil
end

def find_at_risk_square(line, board, marker)
  return unless board.values_at(*line).count(marker) == 2

  board.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
end

computer_running_total = 0
player_running_total = 0

# rubocop:disable Metrics/BlockLength
loop do
  board = intialize_board

  loop do
    display_board(board)

    player_places_piece!(board)
    break if someone_won?(board) || board_full?(board)

    computer_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    prompt("#{detect_winner(board)} won!")
  else
    prompt("It's a tie!")
  end

  if detect_winner(board) == 'Player'
    player_running_total += 1
  elsif detect_winner(board) == 'Computer'
    computer_running_total += 1
  end

  puts "Player: #{player_running_total}, Computer: #{computer_running_total}"
  puts 'First to five wins the game!'

  if computer_running_total == 5 || player_running_total == 5
    puts computer_running_total == 5 ? 'COMPUTER is the grand winner!' : 'Humans won!'
  end

  prompt('Play again? (y or n)')
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
# rubocop:enable Metrics/BlockLength

prompt 'Thanks for playing Tic Tac Toe. Goodbye!'
