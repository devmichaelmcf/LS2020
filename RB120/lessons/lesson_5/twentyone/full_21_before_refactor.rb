
# P.S. need to add in pause and clean up display,

# Format the display card method possibly.

# Also tidy up convaluted GameEngine class.

# Maybe fix dealer turn in GAME ENGINE. Make is so only a method invocation rather than million lines of logic.

# likely remove a #HINT method in total type as doesn't look like EVER used.

require "pry"

module Hintable                # I DON'T THINK THE BELOW GETS USED
  
  def create_total_type_object # aim to MOVE lots of stuff to PLAYER class. Like soft total??? Or Handable. Or new module.
    if total_21? #<<<<< ADDING a 21 object not caring if soft or hard
      Total21.new(player_total)
    elsif soft_total_18_or_above?
      SoftTotal18AndAbove.new(player_total)      # implicit return
    elsif soft_total_13_to_17?
      SoftTotal13To17.new(player_total)
    elsif hard_total_17_or_higher?
      HardTotal17Plus.new(player_total)
    elsif hard_total_13_to_16?
      HardTotal13To16.new(player_total)
    elsif hard_total_12?
      HardTotal12.new(player_total)
    else 
      Total11AndBelow.new(player_total)
    end
  end
  
  def initialize_player_total_type_object    # remember this is a total type object
    self.player_hand_total_type = create_total_type_object
    #NEED TO CREATE CLASS that looks at plater total and creates the correct total_type (METHOD)
  end
  
  def chance_dealer_busts
    # maybe case method
    case self.dealer_integer
      when 2  then "When dealer's first card total is 2 then there is a 35% chance of dealer busting."
      when 3  then "When dealer's first card total is 3 then there is a 37% chance of dealer busting."
      when 4  then "When dealer's first card total is 4 then there is a 40% chance of dealer busting."
      when 5  then "When dealer's first card total is 5 then there is a 42% chance of dealer busting."
      when 6  then "When dealer's first card total is 6 then there is a 42% chance of dealer busting."
      when 7  then "When dealer's first card total is 7 then there is a 26% chance of dealer busting."
      when 8  then "When dealer's first card total is 8 then there is a 24% chance of dealer busting."
      when 9  then "When dealer's first card total is 9 then there is a 23% chance of dealer busting."
      when 10 then "When dealer's first card total is 10 then there is a 23% chance of dealer busting."
      when 11 then "When dealer's first card total is 11 (an ACE) then there is a 11% chance of dealer busting."
    end
   
  end
  
  
  
  # I AM TRYIG TO have a speciallised display esp for 21 player total (regardless of dealer hand)
  
  def display_hint_oop    # FOR USE ON TOTAL TYPE OBJECTS ONLY!!! OTHERWISE self will cause exceptions.
    #self.dealer_first_cards_value_player_hits_on.empty? ? "Should STAY with #{self.class} definitely!" : "Should HIT and you have #{self.class}"  #<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< NOT FINISHED!!!
    if self.class == Total21
      puts "WELL DONE! You have the best score of 21. ADVISE select STAY as impossible to improve this hand. If you select HIT on a your hand will BUST or potentially become a lesser total (if a soft total)."
    elsif self.dealer_first_cards_value_player_hits_on.empty?
     puts "Should STAY with a #{self.name_description} definitely!"
     puts "#{would_have_hit_information}."
     puts "-----------------------------------------------------"
     puts "#{chance_dealer_busts}"
    else 
      puts "Should HIT and you have #{self.name_description}"
      puts "#{would_have_stayed_information}."
      puts "-----------------------------------------------------"
      puts "#{chance_dealer_busts}"  #<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< NOT FINISHED!!!
    end
    
    
    # working code below just uncomment if need back.
    # if self.dealer_first_cards_value_player_hits_on.empty?
    # puts "Should STAY with a #{self.name_description} definitely!"
    # puts "#{would_have_hit_information}."
    # puts "-----------------------------------------------------"
    # puts "#{chance_dealer_busts}"
    # else 
    #   puts "Should HIT and you have #{self.name_description}"
    #   puts "#{would_have_stayed_information}."
    #   puts "-----------------------------------------------------"
    #   puts "#{chance_dealer_busts}"  #<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< NOT FINISHED!!!
    # end
  end
  
  def would_have_stayed_information
    if self.dealer_first_cards_value_player_stays_on.empty?
      "There was no dealer card possible where the optimal strategy was to stay!"
    elsif self.dealer_first_cards_value_player_stays_on.length == 1
      "We would have guided you to stay IF the dealer showed a first card value of #{self.dealer_first_cards_value_player_stays_on.join}!"
    elsif self.dealer_first_cards_value_player_stays_on.length == 2
      "We would have guided you to stay IF the dealer showed a first card value of #{self.dealer_first_cards_value_player_stays_on.join(" or ")}!"
    else 
      "We would have guided you to stay IF the dealer showed a first card value of #{self.dealer_first_cards_value_player_stays_on[0..-3].join(", ") + ", " + self.dealer_first_cards_value_player_stays_on[-2..-1].join(" or ")}"
    end
  end
  
  def would_have_hit_information
    if self.dealer_first_cards_value_player_hits_on.empty?
      "There was no card the dealer could have that would make hitting the optimal strategy! Unless you are an idiot running idiotic strategy. This is possible and even likely looking at your play human!"
    else
      "We would only have recommended hit on the dealer cards #{self.dealer_first_cards_value_player_hits_on.join(", ")}" 
    end
  end
  
  def ace_in_hand?
    player.hand.any? {|card_obj| card_obj.rank == "ACE" }
  end
  
  def no_ace_in_hand?
    player.hand.none? {|card_obj| card_obj.rank == "ACE" }
  end
  
  def hard_total_12?
    player.total == 12
  end
  
  def total_21?
    player.total == 21
  end
  
  def hard_total_13_to_16?
    player.total >= 13 && player.total <= 16 && no_ace_in_hand?
  end
  
  def hard_total_17_or_higher?
    player.total >= 17 && no_ace_in_hand?
  end
  
  def soft_total_13_to_17?
    player.total >- 13 && player_total <= 17 && ace_in_hand?
  end
  
  def soft_total_18_or_above?    # I want this to return true if player has 18 or above AND an ace
    player.total >= 18 && ace_in_hand?
  end
  
  # BELOW works perfectly but want a more OOP solution.
  
  # def display_optimal_player_first_move_only #remember this invoked on SELF. e.g. GameEngine. Remember this if in a module later.
  #   if soft_total_18_or_above?
  #     puts "You have a 'soft 18 or above!'. This is when you have an ACE AND a total of 18 or higher. The optimal strategy here is to always STAND! But what do I know? It's your choice."
  #   elsif soft_total_13_to_17?
  #     puts "You have a 'soft 13-17'. This is when you have an ACE AND a total of 13-17. The best strategy is ALWAYS HIT!"
  #   elsif hard_total_17_or_higher?
  #     puts "You have a 'hard 17 or HIGHER'. Which is 17 or above with NO ACE. You should definitely STAND here! Again, your choice though."
  #   elsif hard_total_13_to_16?
  #     if (2..6).include?(dealer_first_shown_card_total)
  #       puts "When you have a hard 13-17 and dealer shows a 2-6 then best option is to STAND!"
  #     else
  #       puts "Hard 13-16 facing anything OTHER than dealer 2-6 you should HIT! Too likely the dealer beats your total otherwise."
  #     end
  #   elsif hard_total_12?
  #     if (4..6).include?(dealer_first_shown_card_total)
  #       puts "A hard player total of 12, with dealer showing a 4-6 means you should STAND!!!"
  #     else
  #       puts "Hard total 12, facing anything OTHER than a dealer 4-6 means you should HIT!"
  #     end
  #   else
  #     puts "Everything else HIT!! 11 and below! No downside really to hitting."
  #   end
  # end
  
end

module PauseAndDisplayable
  def slow_down_execution_two_secs
    sleep(2.0)
  end
  
  def slow_down_execution_six_secs                   #ADD BACK IN DELETED TO ADD SPEED TO REFACTOR
    sleep(6.0)
  end
  
  def clear_screen_of_output
    puts `clear`
  end
end


module Handable # Clean up participant class. Likely #<=>, #bust? #total. Remember will need to use self now.
# Option of turning THIS module into a CLASS. AS I only want the behaviors for my participant hands I think a module will be 
# suffiencent. IF was a class Hand then would store as part of each participant state and class methods below on it.
  include Comparable
  
  def <=>(other)      # PLAYER spaceship. Will ALSO define another in DEALER (will tidy up when refactor NOT now)
    self.total <=> other.total
  end
  
  def bust?
    self.total > 21         # this calls the total method which the PLAYER class has access to. (SEE IT BELOW --VVVVV--)
  end
  
  def display_hand
    puts "#{self.name}'s hand is:"
    puts "-------------"
    puts self.hand.join(",\n")
    puts "-------------"
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

class GameEngine
  include PauseAndDisplayable
  include Hintable

  attr_accessor :player, :dealer, :deck, :hints_turned_on, :player_hand_total_type #, :current_turn_participant
  
  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new     # already shuffled. Remember to access individual cards we need to call #cards to return an array.
    @hints_turned_on = nil
    @player_hand_total_type = nil    #This is created after Initial deal. Helps implement perfect strategy hints in OOP way.
            #  BE CAREFUL!!!! Must remember to RESET hints or create new object AFTER play again is YES.
  end
  
  def dealer_first_shown_card_total
    case dealer.hand.first.rank
      when "1".."10" then dealer.hand.first.rank.to_i
      when "ACE"     then 11
      when "KING"    then 10
      when "QUEEN"   then 10
      when "JACK"    then 10
    end
  end
  
  # def display_optimal_player_first_move_only #remember this invoked on SELF. e.g. GameEngine. Remember this if in a module later.
  #   if soft_total_18_or_above?
  #     puts "You have a 'soft 18 or above!'. This is when you have an ACE AND a total of 18 or higher. The optimal strategy here is to always STAND! But what do I know? It's your choice."
  #   elsif soft_total_13_to_17?
  #     puts "You have a 'soft 13-17'. This is when you have an ACE AND a total of 13-17. The best strategy is ALWAYS HIT!"
  #   elsif hard_total_17_or_higher?
  #     puts "You have a 'hard 17 or HIGHER'. Which is 17 or above with NO ACE. You should definitely STAND here! Again, your choice though."
  #   elsif hard_total_13_to_16?
  #     if (2..6).include?(dealer_first_shown_card_total)
  #       puts "When you have a hard 13-17 and dealer shows a 2-6 then best option is to STAND!"
  #     else
  #       puts "Hard 13-17 facing anything OTHER than dealer 2-6 you should HIT! Too likely the dealer beats your total otherwise."
  #     end
  #   elsif hard_total_12?
  #     if (4..6).include?(dealer_first_shown_card_total)
  #       puts "A hard player total of 12, with dealer showing a 4-6 means you should STAND!!!"
  #     else
  #       puts "Hard total 12, facing anything OTHER than a dealer 4-6 means you should HIT!"
  #     end
  #   else
  #     puts "Everything else HIT!! 11 and below! No downside really to hitting."
  #   end
    
  # end
  
  # def ace_in_hand?
  #   player.hand.any? {|card_obj| card_obj.rank == "ACE" }
  # end
  
  # def no_ace_in_hand?
  #   player.hand.none? {|card_obj| card_obj.rank == "ACE" }
  # end
  
  # def hard_total_12?
  #   player.total == 12
  # end
  
  # def hard_total_13_to_16?
  #   player.total >= 13 && player.total <= 16 && no_ace_in_hand?
  # end
  
  # def hard_total_17_or_higher?
  #   player.total >= 17 && no_ace_in_hand?
  # end
  
  # def soft_total_13_to_17?
  #   player.total >- 13 && player_total <= 17 && ace_in_hand?
  # end
  
  # def soft_total_18_or_above?    # I want this to return true if player has 18 or above AND an ace
  #   player.total >= 18 && ace_in_hand?
  # end
  
  # def slow_down_execution_two_secs
  #   sleep(2.0)
  # end
  
  # def slow_down_execution_six_secs
  #   sleep(6.0)
  # end
  
  # def clear_screen_of_output
  #   puts `clear`
  # end
  
  def display_goodbye_message
    puts "Thanks for playing the OOP TWENTYONE game!"
    puts "I will spend your money wisely :-)"
  end

  def set_hints_setting                 # FIX THIS> NOT SETTING HINTS ON :-()
    puts "Do you want STRATEGY hints for your first move turned on?"
    puts "Input (y) to activate hint otherwise any key to exit without activating."
    user_str = gets.chomp
    if user_str.downcase.start_with?("y")
      self.hints_turned_on = true
    else 
      self.hints_turned_on = false
    end
    #self.hints_turned_on = false unless user_str.downcase.start_with?("y")
    #binding.pry
    if hints_turned_on == true
      puts "HINTS are turned ON!"
    else
      puts "HINTS are turned OFF! Humans! Tsk! Tsk! Id shake my head if I had one."
    end
  end
  
  def create_total_type_object # aim to MOVE lots of stuff to PLAYER class. Like soft total??? Or Handable. Or new module.
    if total_21? #<<<<< ADDING a 21 object not caring if soft or hard
      Total21.new(player_total, dealer_first_shown_card_total)
    elsif soft_total_18_or_above?
      SoftTotal18AndAbove.new(player_total, dealer_first_shown_card_total)      # implicit return
    # if soft_total_18_or_above?
    #   SoftTotal18AndAbove.new(player_total, dealer_first_shown_card_total)      # implicit return
    elsif soft_total_13_to_17?
      SoftTotal13To17.new(player_total, dealer_first_shown_card_total)
    elsif hard_total_17_or_higher?
      HardTotal17Plus.new(player_total, dealer_first_shown_card_total)
    elsif hard_total_13_to_16?
      HardTotal13To16.new(player_total, dealer_first_shown_card_total)
    elsif hard_total_12?
      HardTotal12.new(player_total, dealer_first_shown_card_total)
    # elsif total_21?
    #   Total21.new(player_total, dealer_first_shown_card_total)
    else 
      Total11AndBelow.new(player_total, dealer_first_shown_card_total)
    end
  end
  
  def initialize_player_total_type_object    # remember this is a total type object
    self.player_hand_total_type = create_total_type_object
    #NEED TO CREATE CLASS that looks at plater total and creates the correct total_type (METHOD)
  end
  
  
  def play
    display_greeting # Hi welcome to 21.....
    
    loop do
      puts "NEW ROUND starting........"
      slow_down_execution_two_secs # Make pause time set in initialize method then used throughout program. More flexible.
      set_player_and_dealer_names
      set_hints_setting
      initial_deal_and_display   # Only one card visable from dealer remember.
      initialize_player_total_type_object # if hints_turned_on is TRUE else nothing / also reassigns froms old hint object each round.
      #binding.pry
      p player_hand_total_type.display_hint_oop
      main_game
      slow_down_execution_two_secs
      determine_winner_or_tied
      add_border_between_outputs
      
      puts "Do you want to play again? Input (y) to play another game. Any key to exit!"
      user_string = gets.chomp
      #break unless user_string.start_with?("y")
      if user_string.downcase.start_with?("y")
        clear_screen_of_output
        self.deck = Deck.new   # creates a new shuffled deck since one we have used it mutated.
        player.hand = []    # gives player empty hand with no cards from previous round.
        dealer.hand = []    # same for dealer.
      else
        break    # leave game as user did NOT want to play again
      end
    end
    
    display_goodbye_message
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
    add_border_between_outputs
    display_dealer_hand
    slow_down_execution_two_secs
    add_border_between_outputs
    puts "The DEALER'S TOTAL is #{dealer_total}" # Needs to show total.
    add_border_between_outputs
    slow_down_execution_two_secs
    until dealer_total >= 17    # dealer keeps taking cards until his total >= 17. NOT checked for bust condition yet.
      next_card = deck.remove_one_card
      puts "Dealer turned over #{next_card}"
      add_border_between_outputs
      slow_down_execution_two_secs
      dealer.hand  << next_card
      display_dealer_hand
      add_border_between_outputs
      slow_down_execution_two_secs
      puts "The DEALER NEW TOTAL is: #{dealer_total}" # Needs to show total.
      add_border_between_outputs
      slow_down_execution_two_secs
      slow_down_execution_two_secs
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
    slow_down_execution_two_secs
    clear_screen_of_output
  end
  
  def set_player_name # WHY TWO? I like having the two tasks separate. I can removed one individually later with ease.
    player.set_name
    slow_down_execution_two_secs
    clear_screen_of_output
  end
  
  def set_dealer_name  # WHY TWO ^^^^^^^^^^
    dealer.set_name
    slow_down_execution_two_secs
    clear_screen_of_output
  end
  
  def initial_deal_cards_to_both_players 
    2.times { player.hand << deck.remove_one_card }
    2.times { dealer.hand << deck.remove_one_card }
  end
  
  def add_border_between_outputs
    puts ""
    puts "*******************************************"
    puts ""
  end
  
  def display_both_player_hands   ####### #IS THIS USED ANYWHERE?????? SEEMS LIKE I HAVE INITIAL DISPLAY METHOD ALREADY
    display_player_hand
    #puts "#{player.name} total is currently: #{player.total}."
    add_border_between_outputs
    display_one_card_of_dealer_hand
    add_border_between_outputs
    slow_down_execution_two_secs
    #display_optimal_player_first_move_only if hints_turned_on == true
    slow_down_execution_two_secs
  end
  
  def dealer_total
    dealer.total
  end
  
  def display_one_card_of_dealer_hand
    puts "Dealer's card is #{dealer.hand.first}. The second card is HIDDEN!"
    #dealer_total       <<<<< This method not needed as it gives away dealer second card.
  end
  

  def display_dealer_hand
    dealer.display_hand
    
  end
  
  def display_player_hand
    player.display_hand
  end
  
  
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
    #player.turn  I TRIED to do in Player class but #turn needed access to the deck. I didn't want to have deck object in two classes so reverted back to here.
    user_input = ""
    loop do                # DO I NEED THESE FOUR LINES BELOW??????
      slow_down_execution_two_secs
      puts "Your total is: #{player_total}." #  Make this a call to player total
      self.player_hand_total_type = create_total_type_object  # <<<< DELETE THIS IF MESSES UP PROGRAM.
      p player_hand_total_type.display_hint_oop     # <<<< DELETE if breaks program.
      
      slow_down_execution_two_secs
      user_input = user_input_and_validation    # Loop. Only returns with a valid user STRING ^^^ Original method ABOVE ^^^

      break if user_input.== "s"
      clear_screen_of_output
    
      card_removed = deck.remove_one_card # Careful with local variable and append setup. CARD OBJECT!!!!! (but has #to_s). 
      player.hand << card_removed     #<< deck.remove_one_card (I DID A DOUBLE APPEND HENCE WHY BUGGED OUT :-)
      puts "The card selected was the #{card_removed}"
      puts ""
      slow_down_execution_two_secs
      display_player_hand
      break puts "You Bust! Your total was #{player_total}." if player.bust?
    end
  end
end

# module Hintable
  
#   def create_total_type_object # aim to MOVE lots of stuff to PLAYER class. Like soft total??? Or Handable. Or new module.
#     if soft_total_18_or_above?
#       SoftTotal18AndAbove.new(player_total, dealer_first_shown_card_total)      # implicit return
#     elsif soft_total_13_to_17?
#       SoftTotal13To17.new(player_total, dealer_first_shown_card_total)
#     elsif hard_total_17_or_higher?
#       HardTotal17Plus.new(player_total, dealer_first_shown_card_total)
#     elsif hard_total_13_to_16?
#       HardTotal13To16.new(player_total, dealer_first_shown_card_total)
#     elsif hard_total_12?
#       HardTotal12.new(player_total, dealer_first_shown_card_total)
#     else 
#       Total11AndBelow.new(player_total, dealer_first_shown_card_total)
#     end
#   end
  
#   def initialize_player_total_type_object    # remember this is a total type object
#     self.player_hand_total_type = create_total_type_object
#     #NEED TO CREATE CLASS that looks at plater total and creates the correct total_type (METHOD)
#   end
#   def ace_in_hand?
#     player.hand.any? {|card_obj| card_obj.rank == "ACE" }
#   end
  
#   def no_ace_in_hand?
#     player.hand.none? {|card_obj| card_obj.rank == "ACE" }
#   end
  
#   def hard_total_12
#     player.total == 12
#   end
  
#   def hard_total_13_to_16?
#     player.total >= 13 && player.total <= 16 && no_ace_in_hand?
#   end
  
#   def hard_total_17_or_higher?
#     player.total >= 17 && no_ace_in_hand?
#   end
  
#   def soft_total_13_to_17?
#     player.total >- 13 && player_total <= 17 && ace_in_hand?
#   end
  
#   def soft_total_18_or_above?    # I want this to return true if player has 18 or above AND an ace
#     player.total >= 18 && ace_in_hand?
#   end
  
#   def display_optimal_player_first_move_only #remember this invoked on SELF. e.g. GameEngine. Remember this if in a module later.
#     if soft_total_18_or_above?
#       puts "You have a 'soft 18 or above!'. This is when you have an ACE AND a total of 18 or higher. The optimal strategy here is to always STAND! But what do I know? It's your choice."
#     elsif soft_total_13_to_17?
#       puts "You have a 'soft 13-17'. This is when you have an ACE AND a total of 13-17. The best strategy is ALWAYS HIT!"
#     elsif hard_total_17_or_higher?
#       puts "You have a 'hard 17 or HIGHER'. Which is 17 or above with NO ACE. You should definitely STAND here! Again, your choice though."
#     elsif hard_total_13_to_16?
#       if (2..6).include?(dealer_first_shown_card_total)
#         puts "When you have a hard 13-17 and dealer shows a 2-6 then best option is to STAND!"
#       else
#         puts "Hard 13-17 facing anything OTHER than dealer 2-6 you should HIT! Too likely the dealer beats your total otherwise."
#       end
#     elsif hard_total_12
#       if (4..6).include?(dealer_first_shown_card_total)
#         puts "A hard player total of 12, with dealer showing a 4-6 means you should STAND!!!"
#       else
#         puts "Hard total 12, facing anything OTHER than a dealer 4-6 means you should HIT!"
#       end
#     else
#       puts "Everything else HIT!! 11 and below! No downside really to hitting."
#     end
#   end
  
# end

# module PauseAndDisplayable
#   def slow_down_execution_two_secs
#     sleep(2.0)
#   end
  
#   def slow_down_execution_six_secs
#     sleep(6.0)
#   end
  
#   def clear_screen_of_output
#     puts `clear`
#   end
# end


# module Handable # Clean up participant class. Likely #<=>, #bust? #total. Remember will need to use self now.
# # Option of turning THIS module into a CLASS. AS I only want the behaviors for my participant hands I think a module will be 
# # suffiencent. IF was a class Hand then would store as part of each participant state and class methods below on it.
#   include Comparable
  
#   def <=>(other)      # PLAYER spaceship. Will ALSO define another in DEALER (will tidy up when refactor NOT now)
#     self.total <=> other.total
#   end
  
#   def bust?
#     self.total > 21         # this calls the total method which the PLAYER class has access to. (SEE IT BELOW --VVVVV--)
#   end
  
#   def display_hand
#     puts "#{self.name}'s hand is:"
#     puts "-------------"
#     puts self.hand.join(",\n")
#     puts "-------------"
#   end
  
 
  
#   def total
#     collected_ranks = []
#     aces = 0
    
#     self.hand.each {|card_obj| collected_ranks << card_obj.rank }
#     values_arr = collected_ranks.map do |rank| 
#                     if ("2".."10").to_a.include?(rank)
#                       rank.to_i
#                     elsif ["JACK", "QUEEN", "KING"].include?(rank)
#                       10
#                     elsif rank == "ACE"
#                       aces += 1
#                       11             # THIS whole method seems to work. Tested with rank values 10 x other values.
#                     end
#                   end
                    
#     initial_total = values_arr.sum
#     until initial_total <= 21 || aces == 0
#       aces -= 1
#       initial_total -= 10
#     end
    
#     initial_total    #return value of method
#   end
  
# end


class Participant
  #include Comparable     # included in BOTH player and dealer. REFACTOR later to use inheritance probably.
  include Handable
  include PauseAndDisplayable
  
  
  
  
  attr_accessor :name, :hand
  def initialize
    @name = ""
    @hand = [] # Do i need a hand object? NO!!! Only storing and accessing card obj. Array itself is more than sufficient.
    #@total = 0 # Best to set here for clarity even though thought about using attr setter to initialize it.
  end
  
end

class Player < Participant

  
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
  
  # def user_input_and_validation    # return value is STRING user input
  #   loop do      # loop keeps going until a valid user input is given
  #     puts "Do you want to Hit (h) or Stay (s)? Please enter the key now: "
  #     user_input = gets.chomp.downcase
  #     return user_input if user_input.start_with?("h", "s")
  #     puts "Bad input! Enter 'h' to HIT or 's' to STAY."  
  #   end
  # end
  
  # def turn
  #   user_input = ""
  #     loop do
  #       slow_down_execution_two_secs
  #       puts "Your total is: #{self.total}." #  Make this a call to player total
  #       slow_down_execution_two_secs
  #       user_input = user_input_and_validation    # Loop. Only returns with a valid user STRING ^^^ Original method ABOVE ^^^
  
  #       break if user_input.== "s"
  #       clear_screen_of_output
      
  #       card_removed = deck.remove_one_card # Careful with local variable and append setup. CARD OBJECT!!!!! (but has #to_s). 
  #       player.hand << card_removed     #<< deck.remove_one_card (I DID A DOUBLE APPEND HENCE WHY BUGGED OUT :-)
  #       puts "The card selected was the #{card_removed}"
  #       puts ""
  #       # slow_down_execution_two_secs
  #       display_player_hand
  #       break puts "You Bust! Your total was #{self.total}." if self.bust?
  #     end
  # end
  
end

class Dealer < Participant

  
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
  
  # def to_s
  #   puts "-----"
  #   puts "#{rand}"
    
    
    
  # end
  
  def to_s       # keep. experiment with nicely formatted "card" IMAGE and see what happens.
    "#{rank} of #{suit}"
  end
end

class TotalType
  include Hintable
  
  attr_accessor :name_description, :exact_player_total, :dealer_first_cards_value_player_hits_on, :dealer_first_cards_value_player_stays_on, :dealer_integer
  
  def dealer_card_reasoning    # <<<<<< May need to remove as doesn't appear needed.
    if self.dealer_first_cards_value_player_hits_on.empty?
      "There was no possible dealer card " 
    end
  end
  
  # NOT NEEDED. As when called on array object it can't be located here (needs to be in array class which i can't do.
  # I decided to have in the display_hit_on and display_stay_on method inplementations.)
  
  # def joinor
  #   # looks funky because I'm going to use it on an ARRAY object because i can use it in both hit AND ALSO stay arrays. 
  #   # Remember there is two arrays stored in each total type object. 
    
  #   case self.length
  #     when 1 then self.join
  #     when 2 then self.join(" and ")
  #     else
  #       self[0..-3].join(", ") + ", " + self[-2..-1].join(" and ")
  #   end
  # end
  
  
  def hint
    if dealer_first_cards_value_player_hits_on.empty?
      puts "Best Strategy is to STAND and take NO CARD!"
    else 
      puts "Best strategy showing a #{self.class} versus a dealer is to HIT!"
    end
  end
  
end

class SoftTotal18AndAbove < TotalType
  def initialize(exact_player_total, dealer_integer)        # DAMN we DO need dealer first card. Useful info for providing better outputs
    @exact_player_total = exact_player_total
    @dealer_integer = dealer_integer
    @dealer_first_cards_value_player_hits_on = []
    @dealer_first_cards_value_player_stays_on = [2,3,4,5,6,7,8,9,10,11]
    @name_description = "soft total of 18 or above"
  end
end

class SoftTotal13To17 < TotalType
  def initialize(exact_player_total, dealer_integer)
    @exact_player_total = exact_player_total
    @dealer_integer = dealer_integer
    @dealer_first_cards_value_player_hits_on = [2,3,4,5,6,7,8,9,10,11]
    @dealer_first_cards_value_player_stays_on = []
    @name_description = "soft total of 13 to 17"
  end
end

class HardTotal17Plus < TotalType
  def initialize(exact_player_total, dealer_integer)
    @exact_player_total = exact_player_total
    @dealer_integer = dealer_integer
    @dealer_first_cards_value_player_hits_on = []     # No dealer cards can make best strategy to hit.
    @dealer_first_cards_value_player_stays_on = [2,3,4,5,6,7,8,9,10,11]
    @name_description = "hard total of 17 or above"
  end
end

class HardTotal13To16 < TotalType
  def initialize(exact_player_total, dealer_integer)
    @exact_player_total = exact_player_total
    @dealer_integer = dealer_integer
    #@dealer_first_cards_value_player_hits_on = init_arr_dealer_integers_to_stand_on(dealer_first_card_integer)
    @dealer_first_cards_value_player_hits_on = [7,8,9,10,11]    # lower chance of busting if dealer has these
    @dealer_first_cards_value_player_stays_on = [2,3,4,5,6]   # dealer up to 43% of busting if has these cards
    @name_description = "hard total of 13 to 16"
    # optimal strategy depends on what dealer first card shows
  end
  
  # def init_arr_dealer_integers_to_stand_on(dealer_first_card_integer)
  #   if [2,3,4,5,6].include?(dealer_first_card_integer)
  #     []
  #   else
  #     [1,2,3,4,5,6,7,8,9,10,11]
  #   end
  # end
end

class HardTotal12 < TotalType
  def initialize(exact_player_total, dealer_integer)
    @exact_player_total = exact_player_total
    @dealer_integer = dealer_integer
    #@dealer_first_cards_value_player_hits_on = init_arr_dealer_integers_to_stand_on(dealer_first_card_integer)
    @dealer_first_cards_value_player_hits_on = [2,3,7,8,9,10,11]
    @dealer_first_cards_value_player_stays_on = [4,5,6]         # advise stay as up to 43% chance dealer busts here
    @name_description = "hard total of 12 exactly"
    # optimal strategy depends on what dealer first card shows
  end
  
  # def init_arr_dealer_integers_to_stand_on(dealer_first_card_integer)
  #   if [4,5,6].include?(dealer_first_card_integer)
  #     []
  #   else
  #     [1,2,3,4,5,6,7,8,9,10,11]
  #   end
  # end
end

class Total11AndBelow < TotalType
  def initialize(exact_player_total, dealer_integer)
    @exact_player_total = exact_player_total
    @dealer_integer = dealer_integer
    @dealer_first_cards_value_player_hits_on = [2,3,4,5,6,7,8,9,10,11]  # ALL cards are a HIT!!!!!
    @dealer_first_cards_value_player_stays_on = []
    @name_description = "total of 11 or below"
  end
end

class Total21 < TotalType
  def initialize(exact_player_total, dealer_integer)
    @exact_player_total = exact_player_total
    @dealer_integer = dealer_integer
    @dealer_first_cards_value_player_hits_on = []  # ALL cards are STAY!!!!!
    @dealer_first_cards_value_player_stays_on = [2,3,4,5,6,7,8,9,10,11]
    @name_description = "total of 21"
  end
end

GameEngine.new.play



# my1 = HardTotal13To16.new(14, 8)
# p my1
