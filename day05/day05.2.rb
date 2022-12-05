
file = File.open('./input.txt', 'r')

data = file.read

piles, instructions = data.split("\n\n")

rows = piles.split("\n")

last_row = rows.pop

total_columns = last_row[last_row.size-2].to_i
columns = []
(0..total_columns-1).each{|i|
  columns[i] = []
}

rows.reverse.each{|row|
    split_row = row.scan(/.{1,4}/)

    split_row.each_with_index{|item, i|

        if item.strip != ""
            columns[i] << item[1]
        end
    }

}

instructions.split("\n").each{|instruction|

  move_from_to = instruction.scan(/move\s(\d+)\sfrom\s(\d+)\sto\s(\d+)/)[0].map{|x| x.to_i }
  moves = move_from_to[0]
  from = move_from_to[1]
  to = move_from_to[2]

  from_column = columns[from-1]

  items = from_column.slice!(moves*-1, moves)

  columns[to-1].concat(items)
}

puts  columns.map{|x| x[x.size-1] }.join