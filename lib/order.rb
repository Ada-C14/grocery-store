require 'csv'
require_relative 'customer'

class Order
  attr_reader :id # WELP, HAD TO MAKE ASSUMPTIONS FOR THE REST...
  attr_accessor :products, :customer, :fulfillment_status

  # NOW FOR WAVE 2, WHEN I UNCOMMENT THIS, I GET AN ERROR UNDEFINED FULFILLMENT STATUS LOCAL VARIABLE???
  # acceptable_fulfillment_status = [:pending, :paid, :processing, :shipped, :complete]
  # raise ArgumentError.new("status must be pending, paid, processing, shipped or complete") unless acceptable_fulfillment_status.include?(fulfillment_status)

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products # products collection data hash
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    cost_sum = 0
    products.sum {|k,v| cost_sum += v}
    output = (cost_sum * 1.075).round(2)
    return output
    # sums all the values contained in products
    # then add 7.5% tax
    # round to two decimals
  end

  def add_product(name, price)
    raise ArgumentError.new("Product already exists") if @products.has_key?(name)
    @products[name] = price
  end

  def self.all
    order_array = []

    CSV.read('data/orders.csv').each do |row_entry|
    products_hash = {}
    row_entry[1].split(';') do |product|
          products_hash[product.split(':')[0]] = [product.split(':')[1]] # why can't I make the price .to_f????
    end

    new_order = Order.new(row_entry[0].to_i, products_hash, Customer.find((row_entry[2]).to_i), row_entry[3].to_sym)
    order_array << new_order
    end

    return order_array
  end
end

customer = Customer.all
order = Order.all
pp order