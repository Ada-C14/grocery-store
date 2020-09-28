require_relative 'customer'
require 'csv'
class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    error_1(@fulfillment_status)
  end

  def error_1(fulfillment_status)
    statuses = [:pending, :paid, :processing, :shipped, :complete]
    if statuses.include?(fulfillment_status) == false
      raise ArgumentError.new("Order status error.  Need valid status.")
    end
  end

  def total
    if @products.empty?
      return 0
    else
      total = (@products.values.sum * 1.075).round(2)
    end
    return total
    # A total method which will calculate the total cost of the order by:
    # Summing up the products
    # Adding a 7.5% tax (*.175) = total + sales tax
    # Rounding the result to two decimal places (.round(2))
  end

  def add_product(product_name, price)
    if @products.key?(product_name)
      raise ArgumentError.new("Unaccepted input. Product already exists.")
    end
    return @products[product_name] = price
  end

  def self.helper_split_string_to_hash_method(product)
    products = Hash.new(0)
    product.split(/;/).each do |product_value_pair|
      product, price  = product_value_pair.split(/:/)
      products[product] = price.to_f
    end
    return products
  end

  def self.all
    orders = CSV.read('data/orders.csv').map { |row| row.to_a }
    orders_arr = []
    orders.each do |detail|
      id = detail[0].to_i
      product = Order.helper_split_string_to_hash_method(detail[1])
      customer = Customer.find(detail[2].to_i)
      status = detail[3].to_sym
      orders_arr << Order.new(id, product, customer, status)
    end
    return orders_arr
  end


  def self.find(id)
    Order.all.find {|customer_order| customer_order.id == id}
    end
end

# Parse the list of products into a hash
# This would be a great piece of logic to put into a helper method
# You might want to look into Ruby's split method
# We recommend manually copying the first product string from the CSV file and using pry to prototype this logic
# Turn the customer ID into an instance of Customer
# Didn't you just write a method to do this?

# orders = CSV.read('../data/orders.csv').map { |row| row.to_a }
# pp orders