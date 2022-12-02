
file = File.open('./input.txt', 'r')

data = file.read

groups = data.split(/\n\n/)

highest = 0

groups.each{|group|
    total = group.split(/\n/).map{|x| x.to_i }.sum

    if total > highest
        highest = total
    end
}

puts highest