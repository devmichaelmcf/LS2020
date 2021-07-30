# NOTE: LAST ACTION WAS creating a working comparison, Seems like code relatively functional. 
# Check requirements for the game, See if missed anything. 
# If not start THINKING about how to tidy up code.
# FIrstly BY cleaning up methods. Especially ENGINE class. Have shorter methods and more of them. :-) Great work Michael.



class GameEngine
  #include Comparable      # thought about including it HERE because THIS is where we will be comparing PLAYER and DEALER objects.
  # On second thoughts I then figured better to have in Dealer and Player classes. Because we will use it on a 
  # player or dealer object. Like so:       player #<=> dealer
  # I will define separately in both PLAYER AND DEALER classes but I WILL refector to use class inheritance.
  
  
  # knows of Player
  # knows of Dealer
  # knows of Deck
  # can play a new game
  # can determine if player total and dealer total are TIED.
  # can determine who WINS between player and dealer if both stay.
  
  attr_accessor :player, :dealer, :deck
  
  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new     # already shuffled. Remember to access individual cards we need to call #cards to return an array.
  end

  
  def play
    # p deck.cards
    # procedural explanation of game (declaritive implementation will be done "behind" these method invocations).
    display_greeting # Hi welcome to 21.....
    set_player_name
    initial_deal_cards_to_both_players # remove 2 cards from deck to give to each game participant (player/dealer). 
    display_both_player_hands  # REMEMBER only display ONE for dealer until it is dealer turn.
    player_turn # display prompts and accept user input around "hit" or "stay". Also potential for "bust" hand.
    dealer_turn unless player.bust? #player_turn WAS a BUST # figure out game logic
    determine_winner_or_tied
    #display_game_outcome
  end
  
  def determine_winner_or_tied
    if player.bust? 
      puts "DEALER wins game! Player busted! :-("
    elsif dealer.bust?     # this may be an issue if player busts as dealer not had turn. SHOULD be okay but be mindful.
      puts "PLAYER wins Game. Dealer busted! Go humanity!"
    elsif dealer < player
      puts "Player wins as #{player_total} is GREATER than dealer total: #{dealer_total}"
    elsif dealer > player
      puts "Dealer wins as their total #{dealer_total} is greater than Player total: #{player_total}."
    else
      puts "Player and Dealer tied on, Dealer: #{dealer_total} and Human: #{player_total} respectively."
    end
  end
  
  def dealer_turn
    display_dealer_hand # This needs to show both cards to output (including hidden one).
    puts "The DEALER'S TOTAL is #{dealer_total}" # Needs to show total.
    until dealer_total >= 17    # dealer keeps taking cards until his total >= 17. NOT checked for bust condition yet.
      next_card = deck.remove_one_card
      puts "Dealer turned over #{next_card}"
      dealer.hand  << next_card
      puts "The DEALER NEW TOTAL is: #{dealer_total}" # Needs to show total.
      # dealer needs to add a card from the deck
    end
    
    if dealer.bust?
      puts "Dealer BUSTS!"
    else
      puts "Dealer STAYS on #{dealer_total}."
    end
    # If new total is > 21 then bust (player wins BECAUSE dealer turn NEVER executed when player already bust-SEE line 28)
    # If total >= 17 then end dealer turn
  end
  
  def display_greeting
    puts "Hi motherfuckers! Are we ready to do this?"
  end
  
  def set_player_name
    player.set_name
  end
  
  def initial_deal_cards_to_both_players 
    # okay need to create a shuffled deck of cards first. Let's travel to card class, then deck class.
    2.times { player.hand << deck.remove_one_card }
    2.times { dealer.hand << deck.remove_one_card }
  end
  
  def display_both_player_hands
    display_player_hand
    display_one_card_of_dealer_hand
  end
  
  def dealer_total
    dealer.total
  end
  
  def display_one_card_of_dealer_hand
    puts "Dealer's card is #{dealer.hand.first}. The second card is HIDDEN!"
    dealer_total
  end
  
  def display_player_hand
    puts "YOUR hand is:"
    puts "-------------"
    puts player.hand.join(",\n")
  end
  
  def display_dealer_hand
    puts "The DEALER'S hand is:"
    puts "-------------"
    puts dealer.hand.join(",\n")
  end
  
  def player_total   # make this a call to player.total probably
    player.total  # the self makes it multi-use for Player and Dealer objects. Likely need to use class inheritance to 
    # make this method available for both objects. Implementation should be identical as just checking a "hand" 
    # for numerical value.
  end
  
  
  def player_turn
    user_input = ""
    loop do
      puts "Your total is: #{player_total}."    #  Make this a call to player total
      loop do      # loop keeps going until a valid user input is given
        puts "Do you want to Hit (h) or Stay (s)? Please enter the key now: "
        user_input = gets.chomp.downcase
        break if user_input.start_with?("h", "s")
        puts "Bad input! Enter 'h' to HIT or 's' to STAY."  
      end
      
      break if user_input.== "s"
      unless player.bust?     # NOT CREATED YET
        card_removed = deck.remove_one_card # Careful with local variable and append setup. CARD OBJECT!!!!! (but has #to_s). 
        player.hand << card_removed     #<< deck.remove_one_card (I DID A DOUBLE APPEND HENCE WHY BUGGED OUT :-)
        puts "The card selected was the #{card_removed}"
        # NEXT TIME START HERE. I NEED TO MAKE IT BREAK PLAYER TURN WHEN BUSTS :-)
      end
      
      break puts "You Bust!" if player.bust?
    end
  end
  
end

class Player
  include Comparable    # included TWICE. Remember to REFACTOR to remove dirtiness. Likely class inheritance.
  # knows own name
  # knows own "hand"
  # knows own total
  # can "hit" (get card)
  # can "stay" (end turn)
  # can determine if own hand is "bust" (over 21) or not
  attr_accessor :name, :hand
  def initialize
    @name = ""
    @hand = [] # Do i need a hand object? NO!!! Only storing and accessing card obj. Array itself is more than sufficient.
    #@total = 0   # Best to set here for clarity even though thought about using attr setter to initialize it.
  end
  
  def <=>(dealer_obj)      # PLAYER spaceship. Will ALSO define another in DEALER (will tidy up when refactor NOT now)
    total <=> dealer_obj.total
  end
  
  def bust?
    total > 21         # this calls the total method which the PLAYER class has access to. (SEE IT BELOW --VVVVV--)
  end
  
  def total
    collected_ranks = []
    aces = 0
    
    hand.each {|card_obj| collected_ranks << card_obj.rank }
    values_arr = collected_ranks.map do |rank| 
                    if ("2".."10").to_a.include?(rank)
                      rank.to_i
                    elsif ["JACK", "QUEEN", "KING"].include?(rank)
                      10
                    elsif rank == "ACE"
                      aces += 1
                      11             # THIS whole method seems to work. Tested with rank values 10 x other values.
                    end
                  end
                  
  initial_total = values_arr.sum
  until initial_total <= 21 || aces == 0
    aces -= 1
    initial_total -= 10
  end
  p initial_total
    
  end
  
  def set_name
    puts "What is your name fool?"
    loop do
      user_input = gets.chomp
      break if user_input =~ /[a-z]+/i
      puts "Yo idiot! Input an alphabetical letter dafty head!"
    end
  end
  
end

class Dealer
  include Comparable     # included in BOTH player and dealer. REFACTOR later to use inheritance probably.
  
  # knows own name
  # knows own "hand"
  # knows own total
  # can determine if own hand is "bust" (over 21) or not
  # can "hit" if total is < 17
  # can "stay" if total >= 17
  attr_accessor :name, :hand, :total
  def initialize
    @name = ""
    @hand = [] # Do i need a hand object? NO!!! Only storing and accessing card obj. Array itself is more than sufficient.
    #@total = 0 # Best to set here for clarity even though thought about using attr setter to initialize it.
  end
  
  def <=>(player_obj) # DEALER spaceship. Rememebr one already defined in PLAYER class (will tidy up when refactor NOT now)
    total <=> player_obj.total
  end
  
  def bust?      # SIMILAR to player BUST
    total > 21
  end

  def total
    collected_ranks = []
    aces = 0
    
    hand.each {|card_obj| collected_ranks << card_obj.rank }
    values_arr = collected_ranks.map do |rank| 
                    if ("2".."10").to_a.include?(rank)
                      rank.to_i
                    elsif ["JACK", "QUEEN", "KING"].include?(rank)
                      10
                    elsif rank == "ACE"
                      aces += 1
                      11             # THIS whole method seems to work. Tested with rank values 10 x other values.
                    end
                  end
                  
  initial_total = values_arr.sum
  until initial_total <= 21 || aces == 0
    aces -= 1
    initial_total -= 10
  end
  p initial_total
    
  end
  
  def set_name  # set name here as allowed me to implement polymorphism with player set name. Allowed me to potentially make
  # a generic player/dealer turn method later (hopefully).
    self.name = %w(R2D2 Hal T1000 Apple1 DifferenceEngine).sample
  end
  
  
end

class Deck
  # knows deck of CARDS
  # can deal one card
  attr_accessor :cards
  def initialize
    @cards = create_shuffled_deck_arr_of_card_objects   # shuffled as no time we will use unshuffled deck.
  end
  
  def create_shuffled_deck_arr_of_card_objects   # returns an array of card objects shuffled. Ensure different each time.
    all_ranks = ("2".."10").to_a + %w(JACK QUEEN KING ACE)
    all_suits = %w(HEARTS DIAMONDS CLUBS SPADES)
    
    arr = []
    all_ranks.each do |rank_element|
      all_suits.each do |suit_element|
        arr << Card.new(rank_element, suit_element)
      end
    end
    arr.shuffle
  end
  
  def remove_one_card    # this RETURNS popped card which we then append elsewhere in GameEngine
    # Uncertain about this implementation. Pro. Mutation of deck kept in deck class.
    # Negative. Feels a bit dirty appending return value of a pop to an array. I dunno. I "think" this is least worst option.
    
    cards.pop # don't need guard clause as never reaches zero. Would likely need a dozen players.
  end
end

class Card
  # knows suit
  # knows rank
  # can display suit and value to screen
  attr_accessor :rank, :suit
  
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
  
  def to_s
    "#{rank} of #{suit}"
  end
end

GameEngine.new.play
