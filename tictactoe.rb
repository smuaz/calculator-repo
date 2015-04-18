# Tic tac toe Logic
# 1. Draw board (9 squares)
# 2. Player choose square with default X
# 3. Computer choose square with default O
# 4. Update board
# 5. Check the winner if either X or 0 are all
#    [1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],
#    [1,5,9],[3,5,7]
# or it's a tie when no more square


require 'pry'

WINNING_POSITIONS = [[1,2,3],[4,5,6],[7,8,9],
                     [1,4,7],[2,5,8],[3,6,9],
                     [1,5,9],[3,5,7]]

def draw_board(board)
  system 'clear'
  puts "     |     |     "
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}  "
  puts "     |     |     "
end

def player_picks(board)
  begin
    puts "Choose a position (from 1 to 9) to place a piece"
    player_position = gets.chomp.to_i
  end until empty_square(board).include?(player_position)

  board[player_position] = 'X'
end

def two_in_a_row(hash, pick)
  if hash.values.count(pick) == 2
    hash.select { |k, v| v == ' '}.keys.first
  else
    false
  end
end

def computer_picks(board)
  puts "Computer chooses a square"
  sleep 0.5

  defend_square = nil
  attacked = false

  # Computer priority
  # 1. attack if there's a chance of winning
  # 2. if not attack, defend the square
  # 3. else , randomly choose square

  WINNING_POSITIONS.each do |line|
    defend_square = two_in_a_row({ line[0] => board[line[0]],
                                   line[1] => board[line[1]],
                                   line[2] => board[line[2]]}, 'O')

    if defend_square
      board[defend_square] = 'O'
      attacked = true
      break
    end
  end

  if attacked == false
    WINNING_POSITIONS.each do |line|
      defend_square = two_in_a_row({ line[0] => board[line[0]],
                                     line[1] => board[line[1]],
                                     line[2] => board[line[2]]}, 'X')

      if defend_square
        board[defend_square] = 'O'
        break
      end
    end
  end

  board[empty_square(board).sample] = 'O' unless defend_square
end

def empty_square(board)
  board.select { |k, v| v == ' ' }.keys
end

def is_it_winning(board)
  winner = check_winner(board)
  draw_board(board)
  winner
end

def check_winner(board)
  WINNING_POSITIONS.each do |line|
    return 'Player' if board.values_at(*line).count('X') == 3
    return 'Computer' if board.values_at(*line).count('O') == 3
  end
  nil
end

board = { 1 => ' ', 2 => ' ', 3 => ' ',
          4 => ' ', 5 => ' ', 6 => ' ',
          7 => ' ', 8 => ' ', 9 => ' ' }

draw_board(board)

begin
  player_picks(board)
  winner = is_it_winning(board)
  break if winner

  computer_picks(board)
  winner = is_it_winning(board)
  break if winner

end until empty_square(board).empty?

if winner
  puts "#{winner} won!"
else
  puts "It's a tie!"
end
