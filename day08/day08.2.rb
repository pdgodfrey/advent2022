file = File.open('./input.txt', 'r')

data = file.read

rows = data.split("\n")
total_rows = rows.size
total_columns = rows[0].size

rows = rows.map{|x| x.split("") }

def check_row_column(rows, i, j)
  row = rows[i]

  this_height = row[j]

  north_score = 0
  south_score = 0
  west_score = 0
  east_score = 0

  (j-1).downto(0).each do |x|
    west_score += 1
    if row[x] >= this_height
      break
    end
  end

  (j+1).upto(row.size-1).each do |x|
    east_score += 1
    if row[x] >= this_height
      break
    end
  end

  (i-1).downto(0).each do |x|
    north_score += 1
    if rows[x][j] >= this_height
      break
    end
  end

  (i+1).upto(rows.size-1).each do |x|
    south_score += 1
    if rows[x][j] >= this_height
      break
    end
  end

  return north_score * south_score * east_score * west_score
end

highest_scenic_score = 0
(1..total_rows-2).each do |i|
  (1..total_columns-2).each{|j|
    scenic_score = check_row_column(rows, i, j)

    if scenic_score > highest_scenic_score
      highest_scenic_score = scenic_score
    end
  }
end

puts highest_scenic_score