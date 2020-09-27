require 'csv'
require_relative 'customer'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products # provided a hash with key prod name, value price)
    @customer = customer # pass in from customer class
    @fulfillment_status = fulfillment_status

    raise ArgumentError.new("Invalid fulfillment status") if [:pending, :paid, :processing, :shipped, :complete].include?(@fulfillment_status) != true
  end

  def total
    if @products.empty?
      return 0
    else
      total = (@products.values.sum * 1.075).round(2)
    end
    return total
  end

  def add_product(product_name, price)
    raise ArgumentError.new("product already exists") if @products.key?(product_name)
    # another option: raise ArgumentError.new("product already exists") if @products.any? {|product, price| product == product_name}
    @products[product_name] = price

    return @products
  end

  def self.split_product_csv_helper(csv_products_line)
    all_items = []

    csv_products_line.split(/;/).each do |string| # splits at semi-colon
      single_product = string.split(/:/) # split at the colon:

      all_items.push({single_product[0] => single_product[1].to_f})
      # now we have: [{food1: 4.5}, {food2: 2.5}, etc.]
    end
    all_products = all_items.inject{|memo, obj| memo.merge(obj)}
    # inject w/ merge converts to: [{food1: 4.5, food2: 2.5, etc. }]

    return all_products
  end

  def self.all
    all_order_instances = []

    CSV.read('data/orders.csv').map { |order| order.to_a }.each do |order|
      id = order[0].to_i
      products = split_product_csv_helper(order[1])
      # using the helper method to parse the data for products
      customer_id = order[2].to_i
      fulfillment = order[3].to_sym

      all_order_instances << Order.new(id, products, Customer.find(customer_id), fulfillment)
    end
    return all_order_instances
  end

  def self.find(id)
    return Order.all.find { |order| order.id == id }  # returns the ORder instance if found, else returns nil
  end

end

#NOTES:
# orders_csv = CSV.read('../data/orders.csv').map { |order| order.to_a }
#
#   #pp orders_csv
#
# all_order_instances = []
#
# orders_csv.each do |order|
#   id = order[0].to_i
#   product_array = order[1].split(/;/)  #outputs an array of products
#   all_items = []
#
#   product_array.each do |string|
#     single_product = string.split(/:/) #split at the colon:
#     hash = {
#         single_product[0] => single_product[1].to_f
#     }
#     all_items << hash
#   end
#   all_products = all_items.inject{|memo, obj| memo.merge(obj)}
#
#   customer_id = order[2].to_i
#
#   fulfillment = order[3].to_s
#
#   all_order_instances << [id, all_products, customer_id, fulfillment]
#
# end
#
# pp all_order_instances

