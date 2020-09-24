# Pauline Chane (@PaulineChane on GitHub)
# Ada Developers Academy C14
# Grocery Store - order.rb
# 9/28/2020

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

  # OPTIONAL
  # remove_product (String product_name): remove product w/ key.to_s == product name from @products
  #                                       ArgumentError if product not found, NOT case sensitive
  # WRITE TESTS: (1) successfully add product, (2) successfully raises argument error
end