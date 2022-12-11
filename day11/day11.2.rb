file = File.open('./input.txt', 'r')

data = file.read


@monkeys = []

class Monkey
  attr_accessor :items, :total_inspections, :mod

  def initialize(items,  operation_text, divisible_test, true_result_monkey, false_result_monkey)
    @items = items
    @operation_text = operation_text
    self.instance_eval do
      eval("def do_operation(x); return #{@operation_text}; end")
    end
    @divisible_test = divisible_test
    @true_result_monkey = true_result_monkey
    @false_result_monkey = false_result_monkey
    @total_inspections = 0
    @mod = 1
  end

  def process_item(x)
    #  puts "item: #{x}"
    x = do_operation(x)
    #  puts "item after: #{x}"
    x = x % mod
     # puts "item after mod by #{mod}: #{x}"

    # puts @divisible_test
    if x % @divisible_test == 0
      return x, @true_result_monkey
    else
      return x, @false_result_monkey
    end
  end
end

monkey_data = data.split("\n\n")

@all_divisors = []

monkey_data.each do |item|
  item_data = item.split("\n")

  start_items = item_data[1].strip.gsub("Starting items: ", "").split(", ").map{|x| x.to_i }

  operation_text = item_data[2].strip.gsub("Operation: ", "").gsub("new", "x").gsub("old", "x")

  divisible_test = item_data[3].strip.gsub("Test: divisible by ", "").to_i

  true_result = item_data[4].strip.gsub("If true: throw to monkey ", "").to_i

  false_result = item_data[5].strip.gsub("If false: throw to monkey ", "").to_i

  @all_divisors <<divisible_test

  @monkeys << Monkey.new(start_items, operation_text, divisible_test, true_result, false_result)
end

modulous = @all_divisors.reduce(1, :lcm)

@monkeys.each do |monkey|
  monkey.mod = modulous
end

rounds = 10000

(0..rounds-1).each do |i|
  @monkeys.each do |monkey|
    monkey.items.each{|item|
      new_item, receiving_monkey = monkey.process_item(item)
      @monkeys[receiving_monkey].items << new_item
      monkey.total_inspections += 1
    }
    monkey.items = []
  end
  #

  if (i+1) % 500 == 0
    puts "After round #{i+1}"
    @monkeys.each_with_index{|monkey, j|
      #puts monkey.items.join(",")
      puts "Monkey #{j} : total inspections: #{monkey.total_inspections}"
    }
  end
end

@monkeys = @monkeys.sort{|x, y| y.total_inspections <=> x.total_inspections}

puts @monkeys[0].total_inspections * @monkeys[1].total_inspections