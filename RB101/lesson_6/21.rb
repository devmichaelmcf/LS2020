# rubocop:disable Style/WordArray, Layout/SpaceAfterComma
ordered_deck =  [[2, ['Two',     'Hearts']], [3, ['Three',   'Hearts']], [4, ['Four',   'Hearts']],
                 [5, ['Five',    'Hearts']], [6, ['Six',     'Hearts']], [7, ['Seven',  'Hearts']],
                 [8, ['Eight',   'Hearts']], [9, ['Nine',    'Hearts']], [10,['Ten',    'Hearts']],
                 [10,['Jack',    'Hearts']], [10,['Queen',   'Hearts']], [10,['King',   'Hearts']],
                 [11,['Ace',     'Hearts']],
                 [2, ['Two',   'Diamonds']], [3, ['Three', 'Diamonds']], [4, ['Four',  'Diamonds']],
                 [5, ['Five',  'Diamonds']], [6, ['Six',   'Diamonds']], [7, ['Seven', 'Diamonds']],
                 [8, ['Eight', 'Diamonds']], [9, ['Nine',  'Diamonds']], [10,['Ten',   'Diamonds']],
                 [10,['Jack',  'Diamonds']], [10,['Queen', 'Diamonds']], [10,['King',  'Diamonds']],
                 [11,['Ace ',  'Diamonds']],
                 [2, ['Two',      'Clubs']], [3, ['Three',    'Clubs']], [4, ['Four',     'Clubs']],
                 [5, ['Five',     'Clubs']], [6, ['Six',      'Clubs']], [7, ['Seven',    'Clubs']],
                 [8, ['Eight',    'Clubs']], [9, ['Nine',     'Clubs']], [10,['Ten',      'Clubs']],
                 [10,['Jack',     'Clubs']], [10,['Queen',    'Clubs']], [10,['King',     'Clubs']],
                 [11,['Ace',      'Clubs']],
                 [2, ['Two',     'Spades']], [3, ['Three',   'Spades']], [4, ['Four',    'Spades']],
                 [5, ['Five',    'Spades']], [6, ['Six',     'Spades']], [7, ['Seven',   'Spades']],
                 [8, ['Eight',   'Spades']], [9, ['Nine',    'Spades']], [10,['Ten',     'Spades']],
                 [10,['Jack',    'Spades']], [10,['Queen',   'Spades']], [10,['King',    'Spades']],
                 [11,['Ace',     'Spades']]]
# rubocop:enable Style/WordArray, Layout/SpaceAfterComma

def total(hand_nested_arr)
  aces  = 0
  total = 0
  hand_nested_arr.each do |sub_arr|
    if sub_arr.first == 11
      aces  += 1
      total += 11
    else
      total += sub_arr.first
    end
  end

  return total if total <= 21 || aces == 0

  until total <= 21 || aces == 0
    total -= 10
    aces -= 1
  end

  total
end

def return_hand_and_score(hand_nested_arr, person = 'player')
  current_score = total(hand_nested_arr)

  sentence_arr = []

  hand_nested_arr.each do |sub_arr|
    sentence_arr << sub_arr.last.join(' of ')
  end

  card_sentence_details = sentence_arr.join(', ')

  "The #{person}'s hand is the #{card_sentence_details} for a total of #{current_score}."
end

def bust?(hand)
  total(hand) > 21
end

def dealer_hit_again?(hand)
  total(hand) < 17
end

def return_winner(player, dealer)
  if total(player) > total(dealer)
    :PLAYER
  elsif total(player) < total(dealer)
    :DEALER
  elsif total(player) == total(dealer)
    :DRAW
  end
end

  puts('Hello player! Welcome to the Launch School Blackjack game!'.center(90))
  sleep(2)
  puts('Are you ready?'.center(90))
  sleep(2)
  puts("You'd better be...........................".center(90))
  sleep(2)
  puts("Let's go!".center(90))
  sleep(2)

loop do
  new_deck = ordered_deck.shuffle

  puts('Dealing cards to player and dealer.......'.center(90))
  sleep(4)
  puts('.................'.center(90))
  sleep(3)

  player_hand = []
  dealer_hand = []

  # initial deal for player
  player_hand << new_deck.pop << new_deck.pop

  # initial deal for dealer
  dealer_hand << new_deck.pop << new_deck.pop

  puts return_hand_and_score(player_hand, 'player')
  sleep(3)
  puts ' '
  puts return_hand_and_score(dealer_hand[0..-2], 'dealer')
  sleep(3)

  player_is_bust_flag = false
    # start of player turn
    loop do
      puts ' '
      puts('Do you wish to HIT (H) or STAY (S). Enter now: ')
      hit_or_stay = gets.chomp
      if hit_or_stay.downcase.start_with?('h')
        current_card = new_deck.pop
        puts ' '
        puts "Player turns over the: #{current_card.last.join(' of ')}"
        puts ' '
        sleep(3)
        player_hand << current_card
        puts return_hand_and_score(player_hand)
        if bust?(player_hand)
          puts 'You BUST! Player LOSES! Dealer WINS!'
          sleep(3)
          player_is_bust_flag = true
          break
        end
      else
        break
      end
    end
    # end of player turn choices

    dealer_is_bust_flag = false
    # dealer turn start
    if player_is_bust_flag == false
      puts('The dealer turns over both cards!')
      puts ' '
      sleep(3)
      puts(return_hand_and_score(dealer_hand, 'dealer'))

      while dealer_hit_again?(dealer_hand) || player_is_bust_flag
        puts ' '
        sleep(3)
        puts('Dealer takes another card...')
        puts ' '
        sleep(3)
        next_dealer_card = new_deck.pop
        puts "Dealer turns over #{next_dealer_card.last.join(' of ')}"
        puts ' '
        sleep(3)
        dealer_hand << next_dealer_card
        puts(return_hand_and_score(dealer_hand, 'dealer'))
        if bust?(dealer_hand)
          puts ' '
          sleep(3)
          puts "DEALER BUST! Player wins! WELL DONE! Dealer total was: #{total(dealer_hand)}"
          dealer_is_bust_flag = true
        end
      end
    end

    sleep(3) # dealer turn end

    if  player_is_bust_flag == false && dealer_is_bust_flag == false
      sleep(3)
      puts ' '
      puts("The player total is: #{total(player_hand)}. The dealer total is: #{total(dealer_hand)}.")
      sleep(3)
      puts ' '
      puts("The winner is: #{return_winner(player_hand, dealer_hand)}")
      puts ' '
      sleep(3)
    end

    puts('The game is completed! Do you want to play again? (Y)es or any key to exit: ')
    play_again = gets.chomp
    break unless play_again.downcase.start_with?('y')
end
