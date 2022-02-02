# Vending Machine

def optimized_change(change, money_valid)
  change_opt = []
  money_valid.each do |value|
    unless change == 0 || value > change
      qty = change/value
      change -= value * qty
      change_opt.push([value, qty])
    end
  end
  puts "Minimum number of bills and/or coins for the change:"
  change_opt.each {|value, qty| puts "#{qty}: $#{value}"}
end

def buy(product_cost, money_valid)
  amount_insert = 0
  until amount_insert >= product_cost
    puts "To complete this purchase insert $#{product_cost - amount_insert} or more:"
    print "Insert a bill or coin ($): "
    input_user = gets.chomp.to_i
    if money_valid.include?(input_user)
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

quit = false
until quit == true
  # menu
  puts "----------*------------"
  puts "Welcome to K soft drink!"
  products.each { |product| puts "#{product[:id]}. #{product[:name].rjust(7)}:\t$#{product[:cost]} "}
  option_quit = products.size.next
  puts "#{option_quit}. Quit"
  print "Choose a option: "
  option = gets.chomp.to_i
  case option
  when 1..products.length
    product_to_buy = products.find { |product| product[:id] == option } # return a product specific.  
    if product_to_buy[:qty] > 0
      money_valid = [5_000, 2_000, 1_000, 500, 200, 100]
      change = buy(product_to_buy[:cost], money_valid) # make a purchase
      puts "\nPurchase successfull: $#{product_to_buy[:cost]} | Change: $#{change}\n\n"
      #optimized_change(change, money_valid)
    else
      puts "#{product_to_buy[:qty]} out of stock!"
      puts "Sorry, invite you a take another product!"
    end
  when option_quit then return true
  else 
    puts "<< Incorrect option, try again >>"
  end
end