file = File.open('./input.txt', 'r')

data = file.read


@screen_lines = {
  0 => Array.new(40) { |i| " " },
  40 => Array.new(40) { |i| " " },
  80 => Array.new(40) { |i| " " },
  120 => Array.new(40) { |i| " " },
  160 => Array.new(40) { |i| " " },
  200 => Array.new(40) { |i| " " },
}


@keys = @screen_lines.keys.reverse

cycles = 0

x = 1

def check_drawing(cycles, x)

  adjusted_cycles = cycles%40

  if [x-1, x, x+1].include?(adjusted_cycles)
    @keys.each{|k|
      if k <= cycles
        @screen_lines[k][adjusted_cycles] = "#"
        break
      end
    }
  end
end

data.split("\n").each do |item|
  if item == "noop"
    #puts "item: #{item}"
    check_drawing(cycles, x)
    cycles += 1
  elsif item =~ /^addx/
    #puts "item[0]: #{item}"
    value = item.split(" ")[1].to_i
    check_drawing(cycles, x)
    cycles += 1
    #puts "item[1]: #{item}"
    check_drawing(cycles, x)
    cycles += 1
    x += value
  end
end

@screen_lines.each do |k, v|
  puts v.join
end