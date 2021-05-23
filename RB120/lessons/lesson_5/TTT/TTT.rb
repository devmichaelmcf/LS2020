class Board
  def initialize
    # board data structure that is mutable for recoding moves. Initilaised to all EMPTY SQUARE
    # num free squares (num or location) possibly
  end
end 

class Player
  def initialize
    # mark is this player an X or an O
    # current_move
    # name
  end
  
  def mark
  end

  def play
  end
end

class Square
  def initialize
    # state of individual square. Is it EMPTY or X or O. Start ALL EMPTY and available.
  end
end

class TTTGame
  def initialize
    # has two players
    # has one board
  end 
  
  def play
    loop
      display_welcome_message
        loop do
          player1.take_turn
          player2.take_turn
          break if either player wins
        end
      display_player_win_message
      break unless play_again?
     end  
     display_goodbye_message
  end
  
  def display_welcome_message
  end
  
  
  def display_goodbye_message
  end
  
  def take_turn
  end
  
  def display_player_win_message
  end
end

game = TTTGame.new
game.play