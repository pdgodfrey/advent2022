
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
  'X' => ['C', 'A', 'B'], #Rock beats scissors, draws with rock, loses to paper
  'Y' => ['A', 'B', 'C'], #Paper beats Rock, draws with paper, loses to scissors
  'Z' => ['B', 'C', 'A']  #Scissors beats Paper, draws with scissors, loses to rock
}

score = 0

battles.each_with_index{|battle, i|
  input_response = battle.split(" ")

  score += values[input_response[1]]

  response_index = win_loss[input_response[1]].find_index(input_response[0])

  if response_index == 0 #win
    score += 6
  elsif response_index == 1 #draw
    score += 3
  end
  #nothing for loss

}

puts score