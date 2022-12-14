require 'json'

file = File.open('./input.txt', 'r')


data = file.read.split("\n")

puts data.inspect

rows = []

min_x = 99999999999
min_y = 99999999999
max_x = 0
max_y = 0

data.each do |datum|
  #puts datum
  coords = datum.split(" -> ")

  (0..coords.size-2).each{|i|
    coord = coords[i].split(",").map{|x| x.to_i }
    next_coord = coords[i+1].split(",").map{|x| x.to_i }

    # puts "coord #{coord.inspect}"
    #puts "next coord #{next_coord.inspect}"

    small_x, big_x = coord[0] > next_coord[0] ? [next_coord[0], coord[0]] : [coord[0], next_coord[0]]
    small_y, big_y = coord[1] > next_coord[1] ? [next_coord[1], coord[1]] : [coord[1], next_coord[1]]

    #puts "Y: #{small_y}..#{big_y}"
    # puts "X: #{small_x}..#{big_x}"

    (small_y..big_y).each{|y|
      (small_x..big_x).each{|x|
        # puts "y,x:  #{y},#{x}"
        if !rows[y]
          rows[y] = []
        end
        if y < min_y
          min_y = y
        end
        if x < min_x
          min_x = x
        end
        if y > max_y
          max_y = y
        end
        if x > max_x
          max_x = x
        end
        rows[y][x] = "#"
      }
    }
  }
end

max_x = max_x * 2

# max_size = 0
# rows.each do |row|
#   if row
#     if row.size > max_size
#       max_size = row.size
#     end
#   end
# end

rows[rows.size] = Array.new(max_x)

rows[rows.size] = Array.new(max_x)

rows = rows.map{|x|
  if x.class == Array
    puts "#{max_x}:#{x.size}"
    if x.size < max_x

      x.concat(Array.new(max_x - x.size))
    end
    # puts x.size
    x
  else
    Array.new(max_x)
  end
  #x.class == Array ? x : Array.new(max_x)
}
rows.each{|row|
  # puts row.size
  row.map!{|x| x == nil ? "." : "#"}
}

rows[rows.size-1].map!{|x| "#"}

# rows.each{|row|
#   puts row[490,max_size].join(" ")
# }

done = false
counter = 0
while done == false
#   (0..25).each do |x|
  current_x = 500
  current_y = 0

  if rows[current_y][current_x] == "o"
    done = true
  else

    while current_x && current_y
      #puts "#{current_y+1} #{current_x} :: #{rows.size}"


      if (current_y+1) >= rows.size
        done = true
        current_y = nil
        current_x = nil
      elsif rows[current_y+1][current_x] == "."
        current_y = current_y + 1
      elsif rows[current_y+1][current_x-1] == "."
        current_y = current_y + 1
        current_x = current_x - 1
      elsif rows[current_y+1][current_x+1] == "."
        current_y = current_y + 1
        current_x = current_x + 1
      else
        rows[current_y][current_x] = "o"
        current_y = nil
        current_x = nil
      end

    end
  end

  counter += 1 unless done

end
# rows.each_with_index{|row, i|
#   puts "#{i+1} :: #{row.slice(450, 525).join("")}"
  # puts row.size
  # puts row.slice(485, 40).size
  # puts "#{i+1} :: #{row.slice(485, 40).join("")}"
# }
# puts rows[0].size
puts counter
# puts "#{min_x} : #{max_x}"
# puts "#{min_y} : #{max_y}"