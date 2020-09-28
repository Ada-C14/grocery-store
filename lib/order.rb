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

  # Error helper method for confirming valid fulfillment status
  def error_1(fulfillment_status)
    statuses = [:pending, :paid, :processing, :shipped, :complete]
    if statuses.include?(fulfillment_status) == false
      raise ArgumentError.new("Order status error.  Need valid status.")
    end
  end

  # Total method - Sums products adds 7.5% tax
  # Rounding the result to two decimal place
  def total
    if @products.empty?
      return 0
    else
      total = (@products.values.sum * 1.075).round(2)
    end
    return total
  end

  def add_product(product_name, price)
    if @products.key?(product_name)
      raise ArgumentError.new("Unaccepted input. Product already exists.")
    end
    return @products[product_name] = price
  end

  # Parse the list of products into a hash
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