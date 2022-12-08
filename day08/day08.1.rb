file = File.open('./input.txt', 'r')

data = file.read

rows = data.split("\n")
total_rows = rows.size
total_columns = rows[0].size

total_outside = (total_rows*2) + ((total_columns-2)*2)

rows = rows.map{|x| x.split("") }

def check_row_column(rows, i, j)
  row = rows[i]

  this_height = row[j]

  visible_west = true
  visible_east = true
  visible_north = true
  visible_south = true

  row.each_with_index do |height, x|
    next if x == j

    if height >= this_height
      if x < j
        visible_west = false
      else
        visible_east = false
      end

    end
  end

  if !visible_east && !visible_west
    rows.each_with_index do |row, x|
      next if x == i

      if row[j] >= this_height
        if x < i
          visible_north = false
        else
          visible_south = false
        end
      end
    end
  end

  return visible_west || visible_east || visible_north || visible_south
end


(1..total_rows-2).each do |i|
  (1..total_columns-2).each{|j|
    item_is_visible = check_row_column(rows, i, j)

    if item_is_visible
      total_outside += 1
    end
  }
end

puts total_outside