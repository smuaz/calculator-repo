def calculate_total(cards)
  # [['H', '3'], ['S', 'K'], ...]
  arr = cards.map{ |e| e[1] }

  total = 0
  arr.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0 # J, K, Q
      total += 10
    else
      total += value.to_i
    end
  end

  #correct for Aces
  arr.select{ |e| e == "A"}.count.times do
    total -= 10 if total > 21
  end

  total
end

puts "Welcome to Blackjack"

suits = ['H', 'D', 'S', 'C']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

deck = suits.product(cards)
deck.shuffle!

#deal cards

mycards = []
dealercards = []

mycards << deck.pop
dealercards << deck.pop
mycards << deck.pop
dealercards << deck.pop

dealertotal = calculate_total(dealercards)
mytotal = calculate_total(mycards)

#show cards

puts "Dealer has: #{dealercards[0]} and #{dealercards[1]} for a total of #{dealertotal}"
puts "You have: #{mycards[0]} and #{mycards[1]} for a total of #{mytotal}"
puts ""

if mytotal == 21
  puts "Congratulations, you hit blackjack!"
end

while mytotal < 21
  puts "What would you like to do? 1) hit or 2) stay"
  hit_or_stay = gets.chomp

  if !['1', '2'].include?(hit_or_stay)
    puts "Error: you must enter either 1 or 2"
    next
  end

  if hit_or_stay == "2"
    puts "You chose to stay"
    break
  end

  new_card = deck.pop
  puts "Dealing card to player: #{new_card}"
  mycards << new_card
  mytotal = calculate_total(mycards)

  if mytotal == 21
    puts "Congratulations, you hit blackjack!"
    exit
  elsif mytotal > 21
    puts "Sorry, it looks like you busted!"
    exit
  end
end

# dealer turn

if dealertotal == 21
  puts "Sorry, dealer hit blackjack. You lose."
  exit
end

while dealertotal < 17
  new_card = deck.pop
  puts "Dealing new card for dealer: #{new_card}"
  dealercards << new_card
  dealertotal = calculate_total(dealercards)

  if dealertotal == 21
    puts "Sorry, dealer hit blackjack. You lose."
    exit
  elsif dealertotal > 21
    puts "Congratulations, dealer have busted. You won."
    exit
  end
end

#compare hands

puts "Dealer's cards: "
dealercards.each do |card|
  puts "=> #{card}"
end
puts ""

puts "Your cards: "
mycards.each do |card|
  puts "=> #{card}"
end
puts ""

if dealertotal > mytotal
  puts "Sorry, dealer wins."
elsif dealertotal < mytotal
  puts "Congratulation, you win!"
else
  puts "It's a tie!"
end

exit
