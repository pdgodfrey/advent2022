file = File.open('./input.txt', 'r')

data = file.read

#start = 0,0
#up    = 0,+1
#down  = 0,-1
#right = +1,0
#left  = -1,0

@knot_positions = {
  0 => [0,0],
  1 => [0,0],
  2 => [0,0],
  3 => [0,0],
  4 => [0,0],
  5 => [0,0],
  6 => [0,0],
  7 => [0,0],
  8 => [0,0],
  9 => [0,0]
}

@knot_position_history = {
  0 => [[0,0]],
  1 => [[0,0]],
  2 => [[0,0]],
  3 => [[0,0]],
  4 => [[0,0]],
  5 => [[0,0]],
  6 => [[0,0]],
  7 => [[0,0]],
  8 => [[0,0]],
  9 => [[0,0]]
}



def check_knot_position(direction, leading_knot, trailing_knot)
  return direction if direction == ""
  trailing_knot_before = trailing_knot.clone
  #puts "directoin: #{direction}"
  #puts "trailing before :#{trailing_knot_before}"
  # puts "#{leading_knot} : #{trailing_knot}"
  if (leading_knot[0] - trailing_knot[0]).abs > 1 || (leading_knot[1] - trailing_knot[1]).abs > 1
    if leading_knot[0] == trailing_knot[0]
      trailing_knot[1] += leading_knot[1] > trailing_knot[1] ? 1 : -1
      #puts "x coordinate is same"
    elsif leading_knot[1] == trailing_knot[1]
      trailing_knot[0] += leading_knot[0] > trailing_knot[0] ? 1 : -1
      #puts "y coordinate is same"

    else
      case direction
      when "RU"
        trailing_knot[0] += 1
        trailing_knot[1] += 1
      when "RD"
        trailing_knot[0] += 1
        trailing_knot[1] -= 1
      when "LU"
        trailing_knot[0] -= 1
        trailing_knot[1] += 1
      when "LD"
        trailing_knot[0] -= 1
        trailing_knot[1] -= 1
      when "U"
        trailing_knot[1] += 1
        # trailing_knot[0] += (leading_knot[0]-trailing_knot[0])
        trailing_knot[0] += leading_knot[0] > trailing_knot[0] ? 1 : -1
      when "D"
        trailing_knot[1] -= 1
        trailing_knot[0] += leading_knot[0] > trailing_knot[0] ? 1 : -1
      when "R"
        trailing_knot[0] += 1
        trailing_knot[1] +=  leading_knot[1] > trailing_knot[1] ? 1 : -1
      when "L"
        trailing_knot[0] -= 1
        trailing_knot[1] += leading_knot[1] > trailing_knot[1] ? 1 : -1
      end
      #move diagonally
      # puts "neither match"
    end
  end
  # puts "trailing after :#{trailing_knot}"

  directions = []
  if trailing_knot[0] > trailing_knot_before[0]
    directions << "R"
  elsif trailing_knot[0] < trailing_knot_before[0]
    directions << "L"
  end
  if trailing_knot[1] > trailing_knot_before[1]
    directions << "U"
  elsif trailing_knot[1] < trailing_knot_before[1]
    directions << "D"
  end

  return directions.join
end

data.split("\n").each do |item|
  direction, amount = item.split(" ")
  amount = amount.to_i
  #puts item

  (0..amount-1).each{|i|
    #puts "#{@head_position} : #{@tail_position}"
    case direction
    when "U"
      @knot_positions[0][1] += 1
    when "D"
      @knot_positions[0][1] -= 1
    when "R"
      @knot_positions[0][0] += 1
    when "L"
      @knot_positions[0][0] -= 1
    end
    @knot_position_history[0] << @knot_positions[0].clone

    this_direction = direction
    (1..9).each{|j|
      # puts "this dir #{this_direction}"
      this_direction = check_knot_position(this_direction, @knot_positions[j-1], @knot_positions[j])

      @knot_position_history[j] << @knot_positions[j].clone
    }
  }

end

#puts @head_positions.inspect
#puts @tail_positions.inspect
#
# (0..9).each{|x|
#   puts @knot_position_history[x].inspect
# }
#
puts @knot_position_history[9].uniq.size