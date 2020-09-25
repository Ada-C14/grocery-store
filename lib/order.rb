require 'csv'
require_relative 'customer'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    raise ArgumentError.new("Sorry, that is not a valid fulfillment status.") if ![:pending, :paid, :processing, :shipped, :complete].include?(@fulfillment_status)
  end

  def total
    if @products.empty?
      cost = 0
    else
      cost = (@products.values.sum * 1.075).round(2)
    end
    return cost
  end

  def add_product(name, price)
    if @products.has_key?(name)
      raise ArgumentError.new("Sorry, a product with the same name already exists.")
    else
      @products[name] = price
    end
  end

  def remove_product(name)
    if @products.has_key?(name)
      @products.delete(name)
    else
      raise ArgumentError.new("Sorry, that product cannot be found.")
    end
  end

  def self.all
    order_info = []
    orders = CSV.read('data/orders.csv').map { |order| order.to_a }
    orders.each do |order|
      order_id = order[0].to_i
      products = order[1].split(/;/)
      products_array = []
      products.each do |product|
        single_product = product.split(/:/)
        products_hash = { single_product[0] => single_product[1].to_f }
        products_array << products_hash
      end
      products_and_prices = products_array.inject{ |first, rest| first.merge(rest) }
      customer_id = order[2].to_i
      status = order[3].to_sym
      order_info << Order.new(order_id, products_and_prices, Customer.find(customer_id), status)
    end
    return order_info
  end

  def self.find(id)
    return all.find { |order| order.id == id}
  end

  def self.find_by_customer(customer)
    order_info = Order.all
    return order_info.find_all { |order| order.customer.id == customer}
  end
end
