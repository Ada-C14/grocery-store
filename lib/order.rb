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

  def remove_product(name)
    raise ArgumentError.new("Product not found") if @products.has_key?(name) == false
    @products.delete_if {|key, value| key == name }
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

  def self.find(id_handed) # instructions were to find AN instance so I did that, but in the optional find_by_customer, the method finds all
    self.all.find do |order_instance|
      if order_instance.id == id_handed
        return order_instance
      end
    end
  end

  def self.find_by_customer(customer_id)
    order_instance_array = []
    self.all.find_all do |order_instance|
      if order_instance.customer.id == customer_id
        order_instance_array << order_instance
      end
    end
    if order_instance_array.empty? == true
      raise ArgumentError.new("Customer id not found")
    else
    return order_instance_array
    end
  end

end