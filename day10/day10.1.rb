file = File.open('./input.txt', 'r')

data = file.read


@signal_strengths = {
  20 => 0,
  60 => 0,
  100 => 0,
  140 => 0,
  180 => 0,
  220 => 0
}
cycles = 0


x = 1

def check_signal_strength(cycles, x)
  if @signal_strengths.has_key?(cycles)
    puts "Got key #{cycles} #{x}"
    @signal_strengths[cycles] = cycles*x
  end
end

data.split("\n").each do |item|
  if item == "noop"
    #puts "item: #{item}"
    cycles += 1
    check_signal_strength(cycles, x)
  elsif item =~ /^addx/
    #puts "item[0]: #{item}"
    value = item.split(" ")[1].to_i
    cycles += 1
    check_signal_strength(cycles, x)
    #puts "item[1]: #{item}"
    cycles += 1
    check_signal_strength(cycles, x)
    x += value
  end
end

total = 0
@signal_strengths.each do |k, v|
  total += v
end

puts total