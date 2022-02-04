# Vending Machine

def optimized_change(change, MONEY_VALID)
  # This method return an array with the change.
  change_opt = []

  MONEY_VALID.each do |value|
    unless change == 0 || value > change
      qty = change / value
      change -= value * qty
      change_opt.push([value, qty])
    end
  end
  
  change_opt
end

def buy(product_cost, MONEY_VALID)
  # This method allow paid a product and recieve a change
  amount_insert = 0
  
  until amount_insert >= product_cost
    puts "To complete this purchase insert $#{product_cost - amount_insert} or more:"
    print "Insert a bill or coin ($): "
    input_user = gets.chomp.to_i
    if MONEY_VALID.include?(input_user)
      amount_insert += input_user
    else
      puts "Not valid, please try again!"
    end
  end
  
  change = amount_insert - product_cost
end

# initial data
products = [
  {id: 1, name: "Coke", cost: 2_500, qty: 5},
  {id: 2, name: "Water", cost: 2_000, qty: 4},
  {id: 3, name: "Oatmeal", cost: 1_500, qty: 3},
  {id: 4, name: "Tea", cost: 100, qty: 2}
]

machine_money = 0
quit = false
until quit == true
  puts "----------*------------"  # menu
  puts "Welcome to K soft drink!"
  products.each { |product| puts "#{product[:id]}. #{product[:name].rjust(7)}:\t$#{product[:cost]}" }
  option_quit = products.size.next
  puts "#{option_quit}. Quit"
  print "Choose a option: "
  option = gets.chomp.to_i
  
  case option
  when 1..products.length
    product_to_buy = products.find { |product| product[:id] == option } # return a product specific.  
    if product_to_buy[:qty] > 0
      MONEY_VALID = [5_000, 2_000, 1_000, 500, 200, 100]
      change_value = buy(product_to_buy[:cost], MONEY_VALID) # make a purchase
      puts "\nPurchase successfull: $#{product_to_buy[:cost]} | Change: $#{change_value}\n\n"
      change = optimized_change(change_value, MONEY_VALID)
      puts "Minimum number of bills and/or coins for the change:"
      change.each { |value, qty| puts "#{qty}: $#{value}" } # show change optimized. 
      machine_money += product_to_buy[:cost]
      products.map { |product| product[:qty] -= 1 if product == product_to_buy } # update product quatity.
    else
      puts "#{product_to_buy[:name]} out of stock!"
      puts "Sorry, invite you a take another product!"
    end
  when option_quit
    quit = true
  else 
    puts "<< Incorrect option, try again >>"
  end
end

puts "----------*------------" 
products.each { |product| puts "#{product[:id]}. #{product[:name].rjust(7)} - units: #{product[:qty]}" }
puts "Total money: $#{machine_money}"
