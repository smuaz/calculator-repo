puts "Play Paper Rock Scissors!"

options = { 'p'=> 'paper', 'r'=> 'rock', 's'=> 'scissors'}

loop do
  puts "Choose one: (P/R/S)"
  player_choice = gets.chomp.downcase
  computer_choice = options.keys.sample

  if options.has_key?(player_choice)
    puts "Your picked #{options[player_choice].capitalize} and computer picked #{options[computer_choice].capitalize}"
    if player_choice == computer_choice
      puts "It's a tie."
    elsif (player_choice == 'p' && computer_choice == 'r') || (player_choice == 'r' && computer_choice == 's') || (player_choice == 's' && computer_choice == 'p')
      puts "You won!"
    else
      puts "Computer won!"
    end

    puts "Play again? (Y/N)"
    play = gets.chomp.downcase

    break if play != 'y'

  end

end
