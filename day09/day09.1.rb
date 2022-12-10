file = File.open('./example1.txt', 'r')

data = file.read

#start = 0,0
#up    = 0,+1
#down  = 0,-1
#right = +1,0
#left  = -1,0


@head_position = [0,0]
@tail_position = [0,0]
@head_positions = [[0,0]]
@tail_positions = [[0,0]]

def check_tail(direction)
  if (@head_position[0] - @tail_position[0]).abs > 1 || (@head_position[1] - @tail_position[1]).abs > 1
    if @head_position[0] == @tail_position[0]
      @tail_position[1] += @head_position[1] > @tail_position[1] ? 1 : -1
      #puts "x coordinate is same"
    elsif @head_position[1] == @tail_position[1]
      @tail_position[0] += @head_position[0] > @tail_position[0] ? 1 : -1
      #puts "y coordinate is same"

    else
      case direction
      when "U"
        @tail_position[1] += 1
        @tail_position[0] += (@head_position[0]-@tail_position[0])
      when "D"
        @tail_position[1] -= 1
        @tail_position[0] += (@head_position[0]-@tail_position[0])
      when "R"
        @tail_position[0] += 1
        @tail_position[1] += (@head_position[1]-@tail_position[1])
      when "L"
        @tail_position[0] -= 1
        @tail_position[1] += (@head_position[1]-@tail_position[1])
      end
      #move diagonally
      # puts "neither match"
    end
  end
  @head_positions << @head_position.clone
  @tail_positions << @tail_position.clone
end

data.split("\n").each do |item|
  direction, amount = item.split(" ")
  amount = amount.to_i
  #puts item

  (0..amount-1).each{|i|
    #puts "#{@head_position} : #{@tail_position}"
    case direction
    when "U"
      @head_position[1] += 1
    when "D"
      @head_position[1] -= 1
    when "R"
      @head_position[0] += 1
    when "L"
      @head_position[0] -= 1
    end

    check_tail(direction)
  }
end

puts @head_positions.inspect
puts @tail_positions.inspect

puts @tail_positions.uniq.size