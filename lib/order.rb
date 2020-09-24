require_relative 'customer'
require 'csv'
# require 'awesome_print'

class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    if !([:pending, :paid, :processing, :shipped, :complete].include?(@fulfillment_status))
      raise ArgumentError.new("Unknown fulfillment status")
    end

  end

  def total
    @total = (@products.values.sum * 1.075).round(2)
  end

  def add_product(product_name, price)
    if @products.has_key?(product_name)
      raise ArgumentError.new("Product is already in the order!")
    else
      @products[product_name] = price
    end
  end

  def remove_product(product_name)
    if @products.has_key?(product_name)
      @products.delete(product_name)
    else
      raise ArgumentError.new("No product with that name was found!")
    end
  end

  def self.products_to_hash(products_str)
    products = []
    #"Lobster:17.18;Annatto seed:58.38;Camomile:83.21"
    products_str.split(";").each do |product| #[["Lobster:17.18"],[],[]]
      products << product.split(":")   #[["Lobster", "17.18"],[],[]]
    end
    products_hash = products.to_h #=>[{"Lobster" => "17.18"},{},{}]
    #value string to integer
    products_hash.each do |key, value|
      value = value.to_f
      products_hash[key] = value
    end
    return products_hash #=>[{"Lobster" => 17.18},{},{}]

  end

  def self.all
    orders_arr = []
    CSV.read('data/orders.csv').map { |row| row.to_a }.each do |order|
      orders_arr << Order.new(order[0].to_i, products_to_hash(order[1]), Customer.find(order[2].to_i), order[3].to_sym)
    end
    return orders_arr
  end

  def self.find(id)
    found_order = Order.all.find {|order| id == order.id}
    puts "Order not found!" if found_order == nil
    return found_order
  end

  def self.find_by_customer(customer_id)
    found_order = Order.all.find_all {|order| customer_id == order.customer.id}
    puts "Order not found!" if found_order == nil
    return found_order

  end

end


# customer = Customer.new(111111, "aba@aba.com", {street_address:"111 Keen Way", city:"seattle", state:"WA", zip:98103})
# #
# one = Order.new(1,{ "banana" => 1.99, "cracker" => 3.00 }, customer)
# # p one.customer
#
# p one.fulfillment_status
# one.add_product("boychow", 3.1)
# p one.products
# one.remove_product("banana")
# p one.products
#
# ap Order.find_by_customer(1)
