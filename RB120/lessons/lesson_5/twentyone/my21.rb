class GameEngine

  attr_accessor :player, :dealer, :deck #, :current_turn_participant
  
  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new     # already shuffled. Remember to access individual cards we need to call #cards to return an array.
  end

  
  def play
    display_greeting # Hi welcome to 21.....
    set_player_and_dealer_names

    initial_deal_and_display   # Only one card visable from dealer remember.
    main_game
    determine_winner_or_tied
    #display_game_outcome
  end
  
  def initial_deal_and_display
    initial_deal_cards_to_both_players # remove 2 cards from deck to give to each game participant (player/dealer). 
    display_both_player_hands  # REMEMBER only display ONE for dealer until it is dealer turn.
  end
  
  def set_player_and_dealer_names
    set_player_name
    set_dealer_name
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
  
  def main_game
    player_turn
    dealer_turn # ALWAYS A DEALER TURN. If player BUST then dealer turn only displays both cards and ends.
  end
  
  def dealer_turn
    #return display_dealer_hand if player.bust? # ***Maybe remove as we may always want to witness dealer turn (like casino).***
    puts "Remember you LOST! But let's see the dealer's round anyway!" if player.bust?
    display_dealer_hand
    puts "The DEALER'S TOTAL is #{dealer_total}" # Needs to show total.
    until dealer_total >= 17    # dealer keeps taking cards until his total >= 17. NOT checked for bust condition yet.
      next_card = deck.remove_one_card
      puts "Dealer turned over #{next_card}"
      dealer.hand  << next_card
      display_dealer_hand
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
  
  def set_player_name # WHY TWO? I like having the two tasks separate. I can removed one individually later with ease.
    player.set_name
  end
  
  def set_dealer_name  # WHY TWO ^^^^^^^^^^
    dealer.set_name
  end
  
  def initial_deal_cards_to_both_players 
    2.times { player.hand << deck.remove_one_card }
    2.times { dealer.hand << deck.remove_one_card }
  end
  
  def display_both_player_hands   ####### #IS THIS USED ANYWHERE?????? SEEMS LIKE I HAVE INITIAL DISPLAY METHOD ALREADY
    display_player_hand
    display_one_card_of_dealer_hand
  end
  
  def dealer_total
    dealer.total
  end
  
  def display_one_card_of_dealer_hand
    puts "Dealer's card is #{dealer.hand.first}. The second card is HIDDEN!"
    #dealer_total       <<<<< This method not needed as it gives away dealer second card.
  end
  
  # def display_hand
  #   puts "#{self.class}'s hand is:"
  #   puts "-------------"
  #   puts self.hand.join(",\n")
  #   puts "-------------"
  # end
  def display_dealer_hand
    dealer.display_hand
  end
  
  def display_player_hand
    player.display_hand
    # puts "YOUR hand is:"
    # puts "-------------"
    # puts player.hand.join(",\n")
    # puts "-------------"
  end
  
  # def display_dealer_hand
  #   puts "The DEALER'S hand is:"
  #   puts "-------------"
  #   puts dealer.hand.join(",\n")
  #   puts "-------------"
  # end
  
  def player_total   # make this a call to player.total probably
    player.total  # the self makes it multi-use for Player and Dealer objects. Likely need to use class inheritance to 
    # make this method available for both objects. Implementation should be identical as just checking a "hand" 
    # for numerical value.
  end
  
  def user_input_and_validation    # return value is STRING user input
      loop do      # loop keeps going until a valid user input is given
        puts "Do you want to Hit (h) or Stay (s)? Please enter the key now: "
        user_input = gets.chomp.downcase
        return user_input if user_input.start_with?("h", "s")
        puts "Bad input! Enter 'h' to HIT or 's' to STAY."  
      end
  end
  
  def player_turn
    user_input = ""
    loop do
      puts "Your total is: #{player_total}."    #  Make this a call to player total
      user_input = user_input_and_validation    # Loop. Only returns with a valid user STRING ^^^ Original method ABOVE ^^^

      break if user_input.== "s"
    
      card_removed = deck.remove_one_card # Careful with local variable and append setup. CARD OBJECT!!!!! (but has #to_s). 
      player.hand << card_removed     #<< deck.remove_one_card (I DID A DOUBLE APPEND HENCE WHY BUGGED OUT :-)
      puts "The card selected was the #{card_removed}"
      display_player_hand
      break puts "You Bust! Your total was #{player_total}." if player.bust?
    end
  end
end

module Handable # Clean up participant class. Likely #<=>, #bust? #total. Remember will need to use self now.
  include Comparable
  
  def <=>(other)      # PLAYER spaceship. Will ALSO define another in DEALER (will tidy up when refactor NOT now)
    self.total <=> other.total
  end
  
  def bust?
    self.total > 21         # this calls the total method which the PLAYER class has access to. (SEE IT BELOW --VVVVV--)
  end
  
  def total
    collected_ranks = []
    aces = 0
    
    self.hand.each {|card_obj| collected_ranks << card_obj.rank }
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
    
    initial_total    #return value of method
  end
  
end


class Participant
  #include Comparable     # included in BOTH player and dealer. REFACTOR later to use inheritance probably.
  include Handable
  
  attr_accessor :name, :hand
  def initialize
    @name = ""
    @hand = [] # Do i need a hand object? NO!!! Only storing and accessing card obj. Array itself is more than sufficient.
    #@total = 0 # Best to set here for clarity even though thought about using attr setter to initialize it.
  end
  
  # def <=>(other)      # PLAYER spaceship. Will ALSO define another in DEALER (will tidy up when refactor NOT now)
  #   total <=> other.total
  # end
  
  # def bust?
  #   total > 21         # this calls the total method which the PLAYER class has access to. (SEE IT BELOW --VVVVV--)
  # end
  
  def display_hand
    puts "#{self.name}'s hand is:"
    puts "-------------"
    puts self.hand.join(",\n")
    puts "-------------"
  end
  
  # def total
  #   collected_ranks = []
  #   aces = 0
    
  #   hand.each {|card_obj| collected_ranks << card_obj.rank }
  #   values_arr = collected_ranks.map do |rank| 
  #                   if ("2".."10").to_a.include?(rank)
  #                     rank.to_i
  #                   elsif ["JACK", "QUEEN", "KING"].include?(rank)
  #                     10
  #                   elsif rank == "ACE"
  #                     aces += 1
  #                     11             # THIS whole method seems to work. Tested with rank values 10 x other values.
  #                   end
  #                 end
                  
  # initial_total = values_arr.sum
  # until initial_total <= 21 || aces == 0
  #   aces -= 1
  #   initial_total -= 10
  # end
  
  # initial_total    #return value of method
  # end
  
  
  # def total   # quite long. I had to collected a lot of info that I didn't feel the rest of the app needed. aces, ranks.
  # # felt it was the least bad thing to have it all done within the one method. I DID NOT want @aces instance variable created.
  #   collected_ranks = []
  #   aces = 0
    
  #   hand.each {|card_obj| collected_ranks << card_obj.rank }
  #   values_arr = collected_ranks.map do |rank| 
  #                                     case rank
  #                                       when "2".."10"                    then rank.to_i
  #                                       when "JACK" || "QUEEN" || "KING"  then 10
  #                                       else 
  #                                         aces += 1
  #                                         11
  #                                     end
  #                                   end
                    
  #   initial_total = values_arr.sum
  #   until initial_total <= 21 || aces == 0
  #     aces -= 1
  #     initial_total -= 10
  #   end
  #   initial_total      # THIS METHOD returns the total as an INTEGER
  # end
  
end

class Player < Participant

  
  # def <=>(dealer_obj)      # PLAYER spaceship. Will ALSO define another in DEALER (will tidy up when refactor NOT now)
  #   total <=> dealer_obj.total
  # end
  
  # def bust?
  #   total > 21         # this calls the total method which the PLAYER class has access to. (SEE IT BELOW --VVVVV--)
  # end
  
  # def total
  #   collected_ranks = []
  #   aces = 0
    
  #   hand.each {|card_obj| collected_ranks << card_obj.rank }
  #   values_arr = collected_ranks.map do |rank| 
  #                   if ("2".."10").to_a.include?(rank)
  #                     rank.to_i
  #                   elsif ["JACK", "QUEEN", "KING"].include?(rank)
  #                     10
  #                   elsif rank == "ACE"
  #                     aces += 1
  #                     11             # THIS whole method seems to work. Tested with rank values 10 x other values.
  #                   end
  #                 end
                  
  # initial_total = values_arr.sum
  # until initial_total <= 21 || aces == 0
  #   aces -= 1
  #   initial_total -= 10
  # end
  # p initial_total
    
  # end
  
  def set_name
    user_input = ""
    puts "What is your name fool?"
    loop do
      user_input = gets.chomp
      break if user_input =~ /[a-z]+/i
      puts "Yo idiot! Input an alphabetical letter dafty head!"
    end
    self.name = user_input
  end
  
end

class Dealer < Participant

  
  # def <=>(player_obj) # DEALER spaceship. Rememebr one already defined in PLAYER class (will tidy up when refactor NOT now)
  #   total <=> player_obj.total
  # end
  
  # def bust?      # SIMILAR to player BUST
  #   total > 21
  # end
  
  def set_name  # set name here as allowed me to implement polymorphism with player set name. Allowed me to potentially make
  # a generic player/dealer turn method later (hopefully).
    self.name = %w(R2D2 Hal T1000 Apple1 DifferenceEngine).sample # FORGOT
  end
end

class Deck
  # knows deck of CARDS
  # can deal one card
  attr_accessor :cards
  def initialize
    @cards = create_shuffled_deck_arr_of_card_objects   # shuffled as no time will we use unshuffled deck.
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
