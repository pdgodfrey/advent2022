require 'json'

file = File.open('./input.txt', 'r')

data = file.read

paired_values = data.split("\n\n")

def compare_items(left, right)
  #puts "LEFT #{left} :: #{left.size}"
  #puts "Right #{right} :: #{right.size}"
  if left.size == 0 && right.size == 0
    return
  elsif left.size == 0
    # puts "left is empty"
    return true
  elsif right.size == 0
    # puts "right is empty"
    return false
  else
    l_item = left.shift
    r_item = right.shift


    is_correct = nil
    done = false
    while l_item && r_item && !done
      #puts "LItem: #{l_item.inspect} : #{l_item.class}"
      #puts "RItem: #{r_item.inspect} : #{r_item.class}"

      if l_item.class == Integer && r_item.class == Integer
        #  puts "both are integers"
        if r_item < l_item
          #  puts "right item is bigger, not correct"
          is_correct = false
          done = true
        elsif l_item < r_item
          #    puts "left item is bigger, is correct"
          is_correct = true
          done = true
        end
      else
        l_item = [l_item] if l_item.class == Integer
        r_item = [r_item] if r_item.class == Integer

        #   puts "One item was list, one was int"
        is_correct =  compare_items(l_item, r_item)

        if is_correct == true || is_correct == false
          done = true
        end
      end

      l_item = left.shift
      r_item = right.shift

    end

    if is_correct == nil
      if l_item && !r_item
        #     puts "Got left item, right item is epmty, not right"
        is_correct = false
      elsif !l_item && r_item
        #  puts "Got right item, left item is epmty, this is right"
        is_correct = true
      end
    end

    # puts "Returning is correct #{is_correct}"

    return is_correct

  end
end

total = 0
paired_values.each_with_index do |pair_value, index|
  first_str, second_str = pair_value.split("\n")

  left = JSON.parse(first_str).to_a
  right = JSON.parse(second_str).to_a

  #puts "\n\nPair #{index + 1}"
  #puts "#{left}"
  #puts "#{right}"
  is_correct = compare_items(left, right)

  # puts "== #{is_correct.inspect}"

  puts "Pair #{index+1}: #{is_correct}"
  total += (index + 1) if is_correct

  #break if index + 1 == 21
end

puts total