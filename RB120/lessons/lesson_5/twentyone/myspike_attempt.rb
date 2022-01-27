# NOTES about need for a way to COMPARE
# -------------------------------------
# Need a way to COMPARE player hand total AND dealer hand total.
# State of each object is encapsulated. I need some method of getting access to both.
# Possible:
# 1) Create own class? NO, would be a bit awkward. Player obj, Dealer obj, Compare obj. Would dealer and player then give
# state to compare obj then we would interact with THAT? Bit weird. We'd have to "wipe it". Might have diff state at different
# times as the objects it was meant to be tracking.
# 2) Include comparable module in GameEngine class to allow us to use <=> operator on integer total of each player/dealer obj.
# Yes! This is a good solution.
# 3) Define a Compare module. Define my own <=> method. This method would interact on current obj and call a method like #total
# on it to return an integer.


class GameEngine
  # knows of Player
  # knows of Dealer
  # knows of Deck
  
  # can start a new game
  # can determine if player total and dealer total are TIED.
  # can determine who WINS between player and dealer if both stay.
end

class Player
  # knows own name
  # knows own "hand"
  # knows own total
  
  # can "hit" (get card)
  # can "stay" (end turn)
  # can determine if own hand is "bust" (over 21) or not
end

class Dealer
  # knows own name
  # knows own "hand"
  # knows own total
  
  # can determine if own hand is "bust" (over 21) or not
  # can "hit" if total is < 17
  # can "stay" if total >= 17
end

class Deck
  # knows deck of CARDS
  
  # can deal one card
end

class Card
  # knows suit
  # knows value
  
  # can display suit and value to screen
end