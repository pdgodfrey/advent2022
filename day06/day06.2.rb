
file = File.open('./input.txt', 'r')

data = file.read

(0..data.size-14).each{|x|
  set = data[x..x+13]

  if(set.split("").uniq.join == set)
    puts "#{x+14}"
    break
  end
}