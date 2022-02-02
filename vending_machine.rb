# Vending Machine

def menu_machine(products)
  puts "----------*------------"
  puts "Welcome to K soft drink!"
  products.each { |product| puts "#{product[:id]}. #{product[:name]} | $#{product[:cost]}"}
  option_quit = products.size.next
  puts "#{option_quit}. Quit"

  print "Choose a option: "
  option = gets.chomp.to_i
  case option
  when 1..products.length
    $machine_money << buy(products, option)
  when option_quit  
    final_state(products)
    return true
  else 
    puts "<< Incorrect option, try again >>"
    menu_machine(products)  # recursion. 
  end
  false
end

def final_state(products)
  puts "-------*---------"
  puts "Thank you!"
  products.each { |product| puts "Drink: #{product[:name]} | Units: #{product[:qty]}" }
  money_in = $machine_money.sum
  puts money_in
end

def optimized_change(change, money_valid)
  change_op = []
  money_valid.each do |value|
    unless change == 0 || value > change
      qty = change/value
      change -= value * qty
      change_op.push([value, qty])
    end
  end
  puts "Minimum number of bills and/or coins for the change:"
  change_op.each {|value, qty| puts "#{qty}: $#{value}"}
end

def purchase_done(products, product_buy)
  index_product = products.index(product_buy)
  products[index_product][:qty] -= 1
end

def buy(products, option)
  product_scan = products.select { |product| product[:id] == option } # return an array 
  product_to_buy = product_scan[0] # take the hash element
  if product_to_buy[:qty] > 0
    money_valid = [5_000, 2_000, 1_000, 500, 200, 100]
    amount_insert = 0
    until amount_insert >= product_to_buy[:cost]
      puts "To complete this purchase insert $#{product_to_buy[:cost] - amount_insert} or more:"
      print "Insert a bill or coin ($): "
      input_user = gets.chomp.to_i
      if money_valid.include?(input_user)
        amount_insert += input_user
      else
        puts "Not valid, please try again!"
      end
    end
    change = amount_insert - product_to_buy[:cost]
    balance = ($machine_money.sum + product_to_buy[:cost]) - amount_insert
    if  balance >= 0
      puts "Purchase was successfull: $#{product_to_buy[:cost]} | Total: $#{amount_insert} | Change: $#{change}"
      optimized_change(change, money_valid)
      purchase_done(products, product_to_buy)
      return product_to_buy[:cost] 
    else
      puts " ** Purchase wasn't successfull ** "
      puts " ** Don't have change for return you ** "
      return 0 
    end
  else
    puts "#{product_to_buy[:qty]} out of stock!"
    puts "Sorry, invite you a take another product!"
    return 0
  end
end

# initial data
products = [
  {id: 1, name: "Coke", cost: 2_500, qty: 5},
  {id: 2, name: "Water", cost: 2_000, qty: 4},
  {id: 3, name: "Oatmeal", cost: 1_500, qty: 3},
  {id: 4, name: "Tea", cost: 100, qty: 2}
]

$machine_money = [0] # initial money for changes. 

quit = false
until quit == true
  quit = menu_machine(products)
end