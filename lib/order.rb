require 'csv'
require_relative 'customer'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  ACCEPTABLE_FULFILLMENT_STATUS = [:pending, :paid, :processing, :shipped, :complete]


  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    raise ArgumentError.new("status must be pending, paid, processing, shipped or complete") unless ACCEPTABLE_FULFILLMENT_STATUS.include?(fulfillment_status)
  end

  def total
    cost_sum = 0
    products.sum {|k,v| cost_sum += v}
    output = (cost_sum * 1.075).round(2)
    return output
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
          products_hash[product.split(':')[0]] = product.split(':')[1].to_f
    end

    new_order = Order.new(row_entry[0].to_i, products_hash, Customer.find((row_entry[2]).to_i), row_entry[3].to_sym)
    order_array << new_order
    end

    return order_array
  end


  def self.find(id_handed)

    self.all.find do |order_instance|
      if order_instance.id == id_handed
        return order_instance
      end
    end
  end

end