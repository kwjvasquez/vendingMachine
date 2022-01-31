# Vending Machine

def menu(machine)
  puts "Welcome to K soft drink"
  index = 0
  machine.each do |drink, information|
    puts "#{index += 1}. #{drink} >> $#{information.first}"
  end
  puts "#{index += 1}. Quit"
  print "What do you want to do, today: "
  option = gets.chomp.to_i
end

def compra()
  puts "\nIn construction!\n\n"
end

# Drink name - Cost - Qty in Machine
kmachine = {
  Coke: [2500, 5],
  Water: [2000, 4],
  Oatmeal: [1500, 3],
  Tea: [100, 2]
}

quit = false
until quit == true
  option = menu(kmachine)
  case option
  when 1, 2, 3, 4
    compra()
  when 5
    quit = true
  else
    puts "\n--> Incorrect option, try again! <--\n\n"
  end
end