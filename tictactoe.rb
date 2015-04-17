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

def block_player(board)
  winning_positions = [[1,2,3],[4,5,6],[7,8,9],
                       [1,4,7],[2,5,8],[3,6,9],
                       [1,5,9],[3,5,7]]
  
  winning_positions.each do |line|
    if board[line[0]] == 'O' && board[line[1]] == 'O' && board[line[2]] == ' '
      return line[2]
    elsif board[line[0]] == ' ' && board[line[1]] == 'O' && board[line[2]] == 'O'
      return line[0]
    elsif board[line[0]] == 'O' && board[line[1]] == ' ' && board[line[2]] == 'O'
      return line[1]
    elsif board[line[0]] == 'X' && board[line[1]] == 'X' && board[line[2]] == ' '
      return line[2]
    elsif board[line[0]] == ' ' && board[line[1]] == 'X' && board[line[2]] == 'X'
      return line[0]
    elsif board[line[0]] == 'X' && board[line[1]] == ' ' && board[line[2]] == 'X'
      return line[1]
    end

  end

  return nil
end

def computer_picks(board)
  defend = block_player(board)

  if defend == nil
    computer_position = empty_square(board).sample
    board[computer_position] = 'O'
  else
    board[defend] = 'O'
  end

end

def empty_square(board)
  board.select { |k, v| v == ' ' }.keys
end

def is_it_winning?(board)
  winner = check_winner(board)
  draw_board(board)
  winner
end

def check_winner(board)
  winning_positions = [[1,2,3],[4,5,6],[7,8,9],
                       [1,4,7],[2,5,8],[3,6,9],
                       [1,5,9],[3,5,7]]

  winning_positions.each do |line|
    if board[line[0]] == 'X' && board[line[1]] == 'X' && board[line[2]] == 'X'
      return 'Player'
    elsif board[line[0]] == 'O' && board[line[1]] == 'O' && board[line[2]] == 'O'
      return 'Computer'
    end

  end

  return nil

end

board = { 1 => ' ', 2 => ' ', 3 => ' ',
          4 => ' ', 5 => ' ', 6 => ' ',
          7 => ' ', 8 => ' ', 9 => ' ' }

draw_board(board)

begin
  player_picks(board)
  winner = is_it_winning?(board)
  break if winner != nil

  computer_picks(board)
  winner = is_it_winning?(board)
  break if winner != nil

end until winner || empty_square(board).empty?

if winner
  puts "#{winner} won!"
else
  puts "It's a tie!"
end
