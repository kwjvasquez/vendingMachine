# Vending Machine

def menu(machine)
  puts "Welcome to K soft drink machine."
  index = 1
  machine.each do |drink, price|
    puts "#{index}. #{drink} >> $#{price}"
    index += 1
  end
  puts "#{index}. Quit"
  print "What do you want? choose the option: "
  option = gets.chomp.to_i
end

def information(valid_money)
  puts "\n(INFORMATION) The machine only accept the next bills or coins: "
  valid_money.each { |value| puts "$#{value}" }
end

def return_change(valid_money, change)
  # This method return the change optimized.
  bills_coins = []
  index = 0
  until change == 0
    test_ = change - valid_money[index]
    while test_ >= 0
      change -= valid_money[index]
      bills_coins.push(valid_money[index])
      test_ = change - valid_money[index]
    end
    index += 1
  end
  
  unless bills_coins.empty?
    count = Hash.new(0)
    bills_coins.each { |value| count[value] += 1 }
    puts "Minimum number of bills and/or coins:"
    count.each {|value, amount| puts "#{amount}: $#{value}"}
    puts
  end
end

def buy(machine, option)
  bills_coins_valid = [5000, 2000, 1000, 500, 200, 100]
  amount_due = machine[option - 1][1] #  product cost. 
  amount_input = 0

  until amount_input >= amount_due
    print "Insert bill or coin ($): "
    input_usr = gets.to_i
    if bills_coins_valid.include?(input_usr)
      amount_input += input_usr
    else
      puts "XXX Incorrect input XXX"
      print "Do you want to see the coins and bills valid? yes (y) any character for no: "
      info = gets.chomp 
      information(bills_coins_valid) if info == "y"
    end
  end
  
  change = amount_input - amount_due
  puts "\nPurchase sucessfull: $#{amount_due} | Change: $#{change} | Total: $#{amount_input}\n"
  return_change(bills_coins_valid, change)
  machine[option - 1][2] -= 1 # decrease a product units.
end

# Drink name - Cost - Qty in Machine
kmachine = [
  ["Coke", 2500, 5],
  ["Water", 2000, 4],
  ["Oatmeal", 1500, 3],
  ["Tea", 100, 2]
]

quit = false
until quit == true
  option = menu(kmachine)
  case option
  when 1, 2, 3, 4
    if kmachine[option-1][2] > 0 # evaluate if there is stock.
      buy(kmachine, option)
    else
      puts "\n--> Sorry, out of stock. Invite you a chose another options.  <--\n\n"
    end
  when 5  
    quit = true
  else 
    puts "\n--> Incorrect option, try again! <--\n\n"
  end
end