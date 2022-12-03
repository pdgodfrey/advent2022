
file = File.open('./input.txt', 'r')

data = file.read

rucksacks = data.split(/\n/)

score = 0

alphabet = "abcdefghijklmnopqrstuvwxyz".split("")
upper_alphabet = alphabet.map{|x| x.upcase }


rucksack_groups = rucksacks.each_slice(3).to_a

rucksack_groups.each {|rucksack_group|
  first = rucksack_group[0].split("")
  second = rucksack_group[1].split("")
  third = rucksack_group[2].split("")

  common_value = (first & second & third)[0]  #no error checking but according to the rules this is guaranteed to be a single item

  if common_value == common_value.upcase
    #puts "#{common_value} : #{(upper_alphabet.index(common_value) + 27)}"
    score += (upper_alphabet.index(common_value) + 27)
  else
    #puts "#{common_value} : #{(alphabet.index(common_value) + 1)}"
    score += (alphabet.index(common_value) + 1)
  end

}

puts score