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

def information(money)
  puts "\n(INFORMATION) The machine only accept the next bills or coins: "
  money.each { |value| puts "$#{value}" }
end

def buy(machine, option)
  bills_coins_valid = [5000, 2000, 1000, 500, 200, 100]
  amount_due = machine[option - 1][1] #  product cost. 
  amount_input = 0

  print "Do you want to see the coins and bills valid? yes (y) any character for no: "
  info = gets.chomp 
  information(bills_coins_valid) if info == "y"
  
  until amount_input >= amount_due
    print "Insert bill or coin ($): "
    input = gets.to_i
    amount_input += input
  end
  puts "Reached the amount\n\n"
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
     buy(kmachine, option)
  when 5  
    quit = true
  else 
    puts "\n--> Incorrect option, try again! <--\n\n"
  end
end