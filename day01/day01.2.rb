
file = File.open('./input.txt', 'r')

data = file.read

groups = data.split(/\n\n/)

highest = [3,2,0]

groups.each{|group|
    total = group.split(/\n/).map{|x| x.to_i }.sum

    if total > highest[0]
        highest[0] = total

        highest.sort!
    end
}

puts highest.sum