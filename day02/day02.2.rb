
file = File.open('./input.txt', 'r')

data = file.read

battles = data.split(/\n/)

#Opponent plays
#A for Rock, B for Paper, and C for Scissors
#My Responses:
#X for Rock, Y for Paper, and Z for Scissors

#Values for my choice
values = {
  'X' => 1,
  'Y' => 2,
  'Z' => 3
}

win_loss = {
  'A' => ['Z', 'X', 'Y'], #Rock beats scissors, draws with rock, loses to paper
  'B' => ['X', 'Y', 'Z'], #Paper beats Rock, draws with paper, loses to scissors
  'C' => ['Y', 'Z', 'X']  #Scissors beats Paper, draws with scissors, loses to rock
}


score = 0

battles.each_with_index{|battle, i|
  input_response = battle.split(" ")

  result = input_response[1]

  opponent = input_response[0]

  my_choice = ''

  #X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win.
  if result == "Z" #win
    score += 6
    my_choice = win_loss[opponent][2]
  elsif result == "Y" #draw
    score += 3
    my_choice = win_loss[opponent][1]
  else #lose
    my_choice = win_loss[opponent][0]
  end

  score += values[my_choice]
}

puts score