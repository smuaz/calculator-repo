# Rules of blackjack
# 1.Cards (13 x 4 = 52 cards) are shuffle randomly
# 2.Intially 2 cards from the decks are picked randomly and given to player
# 3.Another 2 cards (Show face up) from the decks leftover are picked randomly and given to dealer.
# 4.Player goes first.
# 5.Check if the sum of the 2 cards is 21, if it is blackjack! if it's not - hit or stay
# 6.Player can choose hit - 1 card will be drawn from decks. If more than 21, busted
# 7.Player can choose hit again (if more than 21, busted) or choose stay - dealer turn
# 8.Dealer's rule - if sum less than 17, dealer hit and hit. else dealer stays. if more than 21, busted. player wins

require 'pry'

def welcome_message
  puts "Welcome to 21 Blackjack Game!"

  puts "-----------------------------"

  puts "What is your name?"
  player_name = gets.chomp

  puts "Welcome #{player_name}! Let's play a black jack game."
  sleep 0.5

  begin
    puts "Are you ready? (y/n)"
    is_ready = gets.chomp.downcase
  end until is_ready == 'y'
end

def play_again
  begin
    puts "Do you want to play again? (y/n)"
    play_again = gets.chomp.downcase
    if play_again == 'n'
      puts "Good bye! See you again"
      exit
    end
  end until play_again == 'y'

  play_blackjack

end

def statistics(highest_number_player, highest_number_dealer)
  puts "--------Statistics--------"
  puts "Total sum of player's card: #{highest_number_player}"
  puts "Total sum of dealers's card: #{highest_number_dealer}"
  puts "--------------------------"
end

def decide_the_winner(player_cards_number, dealer_cards_number)
  highest_number_player = player_cards_number.flatten!.find_all { |i| i < 21 }.max
  highest_number_dealer = dealer_cards_number.flatten!.find_all { |i| i < 21 }.max

  if highest_number_player == highest_number_dealer
    puts "It's a tie!"
  elsif highest_number_player > highest_number_dealer
    puts "You have won!"
  else
    puts "Dealer won!"
  end

  statistics(highest_number_player, highest_number_dealer)
  play_again

end

def check_if_any_blackjacks(player_initial_sum, dealer_initial_sum)
  if player_initial_sum == dealer_initial_sum
    puts "It's a blackjack tie"
    play_again
  elsif player_initial_sum == "Blackjack"
    puts "Player have Blackjack! Player won"
    play_again
  elsif dealer_initial_sum == "Blackjack"
    puts "Dealer have Blackjack! Dealer won"
    play_again
  end
end

def calculate_sum(arr, sum)
  new_arr = arr[0].product(arr[1])
  new_arr.each do |card|
    sum << card.inject(:+)
  end
  return sum.uniq
end

def total_possible_sum(arr)
  sum = []
  i = 0
  cycle = arr.count - 1
  while i < cycle
    calculate_sum(arr, sum)
    arr.shift
    arr.shift
    new_arr = sum.clone
    arr.unshift(new_arr)
    sum.clear
    i += 1
  end

  #p arr
  return arr
end

def get_cards_number(cards, decks)
  arr = []
  cards.each { |k| arr << decks[k] }
  return total_possible_sum(arr)
end

def check_if_player_win(cards)
  cards.flatten!
  if cards.include? (21)
    return 'Blackjack'
  elsif cards.find_all { |i| i < 21 }.any?
    return 'Play'
  else
    return 'Busted'
  end
end

def check_if_dealer_win(cards)
  cards.flatten!
  if cards.include? (21)
    return 'Blackjack'
  elsif cards.find_all { |i| i < 21 }.any?

    if cards.find_all { |i| i < 21 }.max > 16
      return 'Stay'
    else
      return 'Hit'
    end

  else
    return 'Busted'
  end
end

def check_if_player_winning(player_cards, cards, decks)
  puts "Your turn: Do you want to hit or stay? (h/s)"
  player_choice = gets.chomp.downcase
  if player_choice == 'h'
    player_cards << cards.shift
    puts "Your current cards in hand: #{player_cards}"
    play_numbers = get_cards_number(player_cards, decks)
    status = check_if_player_win(play_numbers)

    if status == 'Blackjack'
      puts "You have Blackjack! You have won!"
      play_again
    elsif status == 'Busted'
      puts "You have busted! The Dealer won!"
      play_again
    else
      check_if_player_winning(player_cards, cards, decks)
    end

  elsif player_choice == 's'
    return 'Stay'
  else
    puts "Please choose either h or s"
    check_if_player_winning(player_cards, cards, decks)
  end
end

def check_if_dealer_winning(dealer_cards, cards, decks)

  puts "Current Dealer's card is #{dealer_cards}"
  play_numbers = get_cards_number(dealer_cards, decks)
  status = check_if_dealer_win(play_numbers)

  if status == 'Blackjack'
    puts "Dealer have Blackjack! Dealer won!"
    play_again
  elsif status == 'Hit'
    puts "Dealer choose to hit..."
    sleep 0.5
    dealer_cards << cards.shift
    check_if_dealer_winning(dealer_cards, cards, decks)
  elsif status == 'Stay'
    puts "Dealer choose to stay.."
    sleep 0.5
    return 'Stay'
  elsif status == 'Busted'
    puts "Dealer have busted! You have won!"
    play_again
  end
end

def play_blackjack
  diamond_cards = { "Diamond Ace" => [1, 11], "Diamond 2" => [2], "Diamond 3" => [3], "Diamond 4" => [4],
                    "Diamond 5" => [5], "Diamond 6" => [6], "Diamond 7" => [7], "Diamond 8" => [8], "Diamond 9" => [9],
                    "Diamond 10" => [10], "Diamond Joker" => [10], "Diamond Queen" => [10], "Diamond King" => [10] }

  heart_cards = { "Heart Ace" => [1, 11], "Heart 2" => [2], "Heart 3" => [3], "Heart 4" => [4],
                    "Heart 5" => [5], "Heart 6" => [6], "Heart 7" => [7], "Heart 8" => [8], "Heart 9" => [9],
                    "Heart 10" => [10], "Heart Joker" => [10], "Heart Queen" => [10], "Heart King" => [10] }

  spade_cards = { "Spade Ace" => [1, 11], "Spade 2" => [2], "Spade 3" => [3], "Spade 4" => [4],
                    "Spade 5" => [5], "Spade 6" => [6], "Spade 7" => [7], "Spade 8" => [8], "Spade 9" => [9],
                    "Spade 10" => [10], "Spade Joker" => [10], "Spade Queen" => [10], "Spade King" => [10] }

  club_cards = { "Club Ace" => [1, 11], "Club 2" => [2], "Club 3" => [3], "Club 4" => [4],
                    "Club 5" => [5], "Club 6" => [6], "Club 7" => [7], "Club 8" => [8], "Club 9" => [9],
                    "Club 10" => [10], "Club Joker" => [10], "Club Queen" => [10], "Club King" => [10] }

  puts "Decks are being shuffled ..."
  sleep 0.5
  decks = diamond_cards.merge(heart_cards).merge(spade_cards).merge(club_cards)
  cards = decks.keys.shuffle!

  player_cards = [cards.shift, cards.shift]
  dealer_cards = [cards.shift, cards.shift]

  cards_array = [player_cards, dealer_cards]

  puts "Your card: #{player_cards}"
  puts "Dealer's card: #{dealer_cards.first} (Another card is hidden)"

  player_cards_number = get_cards_number(player_cards, decks)
  dealer_cards_number = get_cards_number(dealer_cards, decks)

  player_initial_sum = check_if_player_win(player_cards_number)
  dealer_initial_sum = check_if_dealer_win(dealer_cards_number)

  check_if_any_blackjacks(player_initial_sum, dealer_initial_sum)

  puts "Player's turn ..."
  player_turn = check_if_player_winning(player_cards, cards, decks)

  if player_turn == 'Stay'
    puts "Dealer's turn ..."
    sleep 0.5
    dealer_turn = check_if_dealer_winning(dealer_cards, cards, decks)

    if dealer_turn == 'Stay'
      puts "Deciding the winner ..."
      sleep 2.0
      player_cards_number = get_cards_number(player_cards, decks)
      dealer_cards_number = get_cards_number(dealer_cards, decks)
      decide_winner = decide_the_winner(player_cards_number, dealer_cards_number)
    end
  end
end

welcome_message
play_blackjack
