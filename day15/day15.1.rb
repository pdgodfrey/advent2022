require 'json'

file = File.open('./input.txt', 'r')


data = file.read.split("\n")

y_offset = 0
x_offset = 0

row_to_check = 10
row_to_check = 2000000


sensor_distances = {}
beacons = []
data.each do |datum|
  sensor_x = datum.gsub(/Sensor.*?x=(-?\d+).*/, '\1').to_i
  sensor_y = datum.gsub(/Sensor.*?y=(-?\d+).*/, '\1').to_i
  beacon_x = datum.gsub(/.*beacon.*?x=(-?\d+).*/, '\1').to_i
  beacon_y = datum.gsub(/.*beacon.*?y=(-?\d+).*/, '\1').to_i

  manhattan_distance = (sensor_y - beacon_y).abs + (sensor_x - beacon_x).abs

  sensor_distances[[sensor_y, sensor_x]] = manhattan_distance
  beacons << [beacon_y, beacon_x]
end


row_ranges = []

sensor_distances.each do |sensor, m_distance|
  sensor_y, sensor_x = sensor
  y_distance = (sensor_y - row_to_check).abs

  next if y_distance >= m_distance #can't overlap the row

  x_distance = (m_distance - y_distance) #max horz distance on row to check

  plus_dist = sensor_x + x_distance
  minus_dist = sensor_x - x_distance

  if(minus_dist > plus_dist)
    row_ranges << [plus_dist, minus_dist]
  else
    row_ranges << [minus_dist, plus_dist]
  end
end

row_ranges.sort!{|x,y| [x[0],x[1]] <=> [y[0], y[1]]}

done = false

while !done
  any_overlaps = false
  (0..row_ranges.size-2).each{|i|
    row_range = row_ranges[i]
    next_row_range = row_ranges[i+1]

    if row_range[1] >= next_row_range[0]
      if next_row_range[1] > row_range[1]
        row_range[1] = next_row_range[1]
      end
      row_ranges.delete_at(i+1)
      any_overlaps = true
      break
    end

  }

  if !any_overlaps
    done = true
  end
end

puts row_ranges.inspect
total = 0
row_ranges.each{|range|
  total += (range[1]-range[0]).abs
}
puts total