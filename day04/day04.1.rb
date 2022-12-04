
file = File.open('./input.txt', 'r')

data = file.read

pairs = data.split(/\n/)

score = 0

pairs.each{|pair|
  first, second = pair.split(",")

  first_min, first_max = first.split("-")
  second_min, second_max = second.split("-")

  first_min = first_min.to_i
  first_max = first_max.to_i
  second_min = second_min.to_i
  second_max = second_max.to_i

  if (first_min <= second_min && first_max >= second_max) || (second_min <= first_min && second_max >= first_max)
    score +=1
  end

}

puts score