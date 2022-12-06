
file = File.open('./input.txt', 'r')

data = file.read

(0..data.size-4).each{|x|
  set = data[x..x+3]

  if(set.split("").uniq.join == set)
    puts "#{x+4}"
    break
  end
}