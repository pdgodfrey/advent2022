file = File.open('./input.txt', 'r')

data = file.read

@rows = data.split("\n").map{|x| x.split("") }

$start_coordinate = nil
$end_coordinate = nil

$alphabet = "SabcdefghijklmnopqrstuvwxyzE".split("")

@rows.each_with_index do |row, i|
  if row.include?("S")
    $start_coordinate = [i, row.index("S")]
  end
  if row.include?("E")
    $end_coordinate = [i, row.index("E")]
  end

  break if $start_coordinate && $end_coordinate
end

class PathStep
  attr_accessor :value, :y, :x, :g_score, :h_score, :next_steps, :prev_step

  def initialize(value, y, x, g_score, prev_step)
    @value = value
    @x = x
    @y = y
    @g_score = g_score
    @h_score = (y - $end_coordinate[0]).abs + (x - $end_coordinate[1]).abs
    @next_steps = []
    @prev_step = prev_step
  end

  def f_score
    #puts "f score modifier #{step_score}"
    return @g_score + @h_score
  end

  def step_score
    if prev_step
      if prev_step.value == "S"
        return 0
      else

        return $alphabet.index(value) - $alphabet.index(prev_step.value)
      end
    else
      return 0
    end
  end
end

def check_value(path_step, y, x)
  this_step_value = $alphabet.index(path_step.value)
  # puts "====#{y} :: #{x}"
  alpha_val = @rows[y][x]

  # puts "#{path_step.value} : #{alpha_val} = #{this_step_value} : #{$alphabet.index(alpha_val)}"

  if $alphabet.index(alpha_val) <= this_step_value || $alphabet.index(alpha_val) == this_step_value + 1
    next_path_step = PathStep.new(alpha_val,
                                  y,
                                  x,
                                  path_step.g_score + 1,
                                  path_step)
    $path_stack << next_path_step
  end
end

def find_next_steps(path_step)
  check_y = path_step.y - 1
  if(check_y != -1 && check_y < @rows.size && !$checked_coordinates.include?([check_y, path_step]))
    # puts "Y1 #{check_y} :: #{@rows.size}"
    # puts "me: #{path_step.y}:#{path_step.x} :: checking #{check_y}:#{path_step.x}"
    check_value(path_step, check_y, path_step.x)
  end

  check_y = path_step.y + 1
  if(check_y != -1 && check_y < @rows.size && !$checked_coordinates.include?([check_y, path_step]))
    # puts "Y2 #{check_y} :: #{@rows.size}"
    # puts "me: #{path_step.y}:#{path_step.x} :: checking #{check_y}:#{path_step.x}"
    check_value(path_step, check_y, path_step.x)
  end



  check_x = path_step.x - 1
  if(check_x != -1 && check_x < @rows[0].size && !$checked_coordinates.include?([path_step.y, check_x]))
    # puts "X1 #{check_x} :: #{@rows[0].size}"
    # puts "me: #{path_step.y}:#{path_step.x} :: checking #{path_step.y}:#{check_x}"
    check_value(path_step, path_step.y, check_x)
  end

  check_x = path_step.x + 1
  if(check_x != -1 && check_x < @rows[0].size && !$checked_coordinates.include?([path_step.y, check_x]))
    # puts "X2 #{check_x} :: #{@rows[0].size}"
    # puts "me: #{path_step.y}:#{path_step.x} :: checking #{path_step.y}:#{check_x}"
    check_value(path_step, path_step.y, check_x)
  end
end

$path_stack = [

]

$checked_coordinates = [
]

# $all_path_steps = []
#
path_step = PathStep.new("S", $start_coordinate[0], $start_coordinate[1], 0,nil )
$path_stack << path_step

$final_step = nil

done = false
while !done
  #puts $path_stack.size
  next_step = $path_stack.shift
  #puts "checking #{next_step.y}:#{next_step.x}"

  if !$checked_coordinates.include?([next_step.y, next_step.x])
    if next_step.value == "E"
      $final_step = next_step
      done = true
    else
      find_next_steps(next_step)
      $checked_coordinates << [next_step.y, next_step.x]
      $path_stack.sort!{|x,y| [x.f_score] <=> [y.f_score] }

      #  puts "#{$path_stack.map{|x| "#{x.f_score}:#{x.y},#{x.x}"}.join("--")}"
    end

  end

  if $path_stack.size == 0
    done = true
  end
end


final_path = []
final_values = []
counter = 0
if $final_step
  #  puts "==#{$final_step.y}:#{$final_step.x}=="
  prev_step = $final_step.prev_step
  #puts "==#{prev_step.y}:#{prev_step.x}=="

  final_path << [prev_step.y, prev_step.x]
  final_values << prev_step.value
  #counter += 1 #don't count step z->E
  while prev_step
    prev_step = prev_step.prev_step
     final_path << [prev_step.y, prev_step.x] if prev_step
    final_values << prev_step.value if prev_step
    counter += 1
  end
end

puts counter

# puts final_path.size
#puts final_values.reverse.join(" > ")

# (0..@rows.size-1).each do |i|
#   (0..@rows[0].size-1).each do |j|
#     if final_path.include?([i,j])
#       @rows[i][j] = "#"
#     else
#       @rows[i][j] = "."
#     end
#   end
# end
#
# @rows.each do |row|
#   puts row.join
# end