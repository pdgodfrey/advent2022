file = File.open('./input.txt', 'r')

data = file.read

path_sizes = {
  "/" => 0
}

path_contents = {
  "/" => []
}

current_path = []

total_space = 70000000
required_space = 30000000

data.split("\n").each { |item|

  if item =~ /^\$ cd /
    dir_change = item.gsub("$ cd ", "")

    # puts "CD #{item}"

    if dir_change == ".."
      current_path.pop if current_path.last == "/"
      current_path.pop
    else
      current_path << dir_change
      current_path << "/" unless dir_change == "/"
    end
    if !path_sizes.has_key?(current_path.join)
      path_sizes[current_path.join] = 0
      path_contents[current_path.join] = []
    end

  elsif item =~ /^dir/
    path_contents[current_path.join] << item
  elsif item =~ /^\d+\s[a-zA-Z\.]+/
    # puts "Path: #{current_path.join + extra_path}"

    size = item.gsub(/^(\d+).*/, '\1')

    test_path = current_path.clone

    while test_path.size > 1
      path_sizes[test_path.join] += size.to_i
      test_path.pop
      test_path.pop
    end
    path_sizes[test_path.join] += size.to_i
  end

}

#puts path_sizes.inspect

total_used_space = path_sizes["/"]

current_available_space = total_space - total_used_space

minimum_to_be_deleted = required_space - current_available_space

# puts current_available_space
# puts required_space
# puts minimum_to_be_deleted

path_sizes.sort_by {|k, v| v}.each{|k,v|
  if v > minimum_to_be_deleted
    puts "DELETE #{k} : #{v}"
    break
  end
}