require 'json'

file = File.open('./input.txt', 'r')

data = file.read

data = data.gsub("[]", "[0]")
data = data.gsub("\n\n", "\n").split("\n")

data << "[[2]]"
data << "[[6]]"

data = data.sort{|x, y|
  x_arr = JSON.parse(x).to_a
  y_arr = JSON.parse(y).to_a

  [x_arr.flatten, x.size] <=> [y_arr.flatten,y.size]
}

# data.each do |item|
#   puts item
# end

divider2 = data.index("[[2]]") + 1
divider6 = data.index("[[6]]") + 1

result = divider2 * divider6

puts result