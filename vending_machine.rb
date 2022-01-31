# Vending Machine

def menu(machine)
  puts "Welcome to K soft drink machine."
  index = 0
  machine.each do |drink, price|
    puts "#{index += 1}. #{drink} >> $#{price}"
  end
  puts "#{index += 1}. Quit"
  print "What do you want? choose the option: "
  option = gets.chomp.to_i
end

def buy()
end

# Drink name - Cost - Qty in Machine
machine = [
  ["Coke", 2500, 5],
  ["Water", 2000, 4],
  ["Oatmeal", 1500, 3],
  ["Tea", 100, 2]
]

quit = false
until quit == true
  option = menu(machine)
  case option
  when 1, 2, 3, 4
     buy()
  when 5  
    quit = true
  else 
    puts "\n--> Incorrect option, try again! <--\n\n"
  end
end