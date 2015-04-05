# 1. Application logic. sequence of steps
# draw_board
# player picks a square
# check_winner
# computer picks a square
# check_winner

# if there is no empty square or there is a winner
#   show_result(tie or someone won)

# 2.translation of those steps into code
require "pry"
board_status = {1 => " ", 2 => " ", 3 => " ",
                4 => " ", 5 => " ", 6 => " ",
                7 => " ", 8 => " ", 9 => " "}
def draw_board(b_s)
  system "clear"
  puts "#{b_s[1]}|#{b_s[2]}|#{b_s[3]}"
  puts "-+-+-"
  puts "#{b_s[4]}|#{b_s[5]}|#{b_s[6]}"
  puts "-+-+-"
  puts "#{b_s[7]}|#{b_s[8]}|#{b_s[9]}"
end

def player_pick_square(b_s)
  empty_squares = get_empty_squares(b_s)
  begin
    puts "please pick a square(1-9):" 
    square_position = gets.chomp.to_i
  end until empty_squares.include?square_position
  b_s[square_position] = "X"
end

def computer_pick_square(b_s)
  square_position = get_empty_squares(b_s).sample
  b_s[square_position] = "O"
end

def get_empty_squares(b_s)
  empty_squares = b_s.select{|k,v| b_s[k] == " "}
  return empty_squares.keys
end

def check_winner(b_s)
  winner_lines = [[1,2,3], [4,5,6], [7,8,9], 
                [1,4,7], [2,5,8], [3,6,9],
                [1,5,9], [3,5,7]]
  winner_lines.each do |arr|
    if b_s[arr[0]] == "X" and b_s[arr[1]] == "X" and b_s[arr[2]] == "X"
      return "Player"
    elsif b_s[arr[0]] == "O" and b_s[arr[1]] == "O" and b_s[arr[2]] == "O"
      return "Computer"
    end
  end 
  return nil
end
def initialize_board!(b_s)
  b_s.each do |k, v|
    b_s[k] = " "
  end

end

loop do
  initialize_board!(board_status)
  draw_board(board_status)
  begin  
    player_pick_square(board_status)
    draw_board(board_status)
    winner = check_winner(board_status)
    break if winner || get_empty_squares(board_status).empty?
    computer_pick_square(board_status)       
    draw_board(board_status)  
    winner = check_winner(board_status)
  end until winner || get_empty_squares(board_status).empty?     
  if winner
    puts "#{winner} won!"
  else
    puts "It's a tie!"
  end
  puts "Play again?(y/n)"
  go_on = gets.chomp.downcase
  break unless go_on == "y"
end

