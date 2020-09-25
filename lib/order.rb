# Pauline Chane (@PaulineChane on GitHub)
# Ada Developers Academy C14
# Grocery Store - order.rb
# 9/28/2020

# imports
require 'csv'

# Class object spec file for Order class.
require_relative 'customer'
class Order
  # class constant with valid statuses
  STATUSES = [:pending, :paid, :processing, :shipped, :complete]

  # generic getters/setters
  attr_reader :id, :products, :customer, :fulfillment_status

  # constructor
  def initialize(id, products, customer, fulfillment_status = :pending)
    # exception for invalid fulfillment_status input
    raise ArgumentError, 'Invalid fulfillment status input. Must be :pending, :paid, :processing, :shipped, or :complete.' unless STATUSES.include?(fulfillment_status)

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  # additional accessors/readers
  # total: sum prices of all products plus 7.5% tax (* 1.075), round 2 decimal places, return float
  def total
    return @products.sum { |product, price| price * 1.075 }.round(2)
  end

  # additional mutators
  # add_product (String product_name, float price): >> @products and NOT case sensitive
  #                                                 ArgumentError if product already added
  def add_product(product, price)
    raise ArgumentError, 'Invalid input. Product already in order.' if @products.key?(product)

    @products[product] = price
  end

  # remove_product (OPTIONAL) (String product_name): remove product w/ key.to_s == product name from @products
  #                                       ArgumentError if product not found, NOT case sensitive
  def remove_product(product)
    raise ArgumentError, 'Invalid input. Product not found in order.' unless @products.key?(product)
    @products.delete(product)
  end

  # class methods
  # based on an external .csv file containing order data,
  # returns collection (in this case, array) of order instances
  def self.all
    orders_raw = CSV.read('data/orders.csv')

    all_orders = orders_raw.map do |order|
      # need to modify string of products/prices before adding as hash parameter for products
      products = order[1].split(';').map{ |pair|
          key, value = pair.split(':')
          { key => value.to_f } }.reduce({}, :merge)

      Order.new(order[0].to_i, products, Customer.find(order[2].to_i), order[3].to_sym)
    end

    return all_orders
  end

  # returns an instance of Order matched by id value entered as parameter in self.all
  # returns nil if id not found
  def self.find(id)
      return self.all.find{|order| order.id == id}
  end

  # returns a list (array) of Order instances with input parameter customer id
  # returns empty array if not found
  def self.find_by_customer(customer_id)
    return self.all.select { |order| order.customer.id == customer_id }
  end
end