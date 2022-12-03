
file = File.open('./input.txt', 'r')

data = file.read

rucksacks = data.split(/\n/)

score = 0

alphabet = "abcdefghijklmnopqrstuvwxyz".split("")
upper_alphabet = alphabet.map{|x| x.upcase }

rucksacks.each {|rucksack|
  pocket1 = rucksack[0..(rucksack.size/2)-1].split("")
  pocket2 = rucksack[(rucksack.size/2)..-1].split("")

  common_value = (pocket1 & pocket2)[0]  #no error checking but according to the rules this is guaranteed to be a single item

  if common_value == common_value.upcase
    #puts "#{common_value} : #{(upper_alphabet.index(common_value) + 27)}"
    score += (upper_alphabet.index(common_value) + 27)
  else
    #puts "#{common_value} : #{(alphabet.index(common_value) + 1)}"
    score += (alphabet.index(common_value) + 1)
  end

}

puts score