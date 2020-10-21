require "csv"
require_relative "customer"

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products = {}, customer = nil, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    if ![:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status)
      raise ArgumentError.new("Invalid Status: #{fulfillment_status}. Must be one of the following: pending, paid, processing, shipped, or complete.")
    end

    @fulfillment_status = fulfillment_status
  end

  def total
    sum = 0
    total = 0

    @products.each do |item, price|
      sum += price
    end

    total = sum + sum * 0.075

    return total.round(2)
  end

  def add_product(product_name, price)
    if @products.keys.include?(product_name)
      raise ArgumentError.new("{#{product_name} already added.")
    end

    @products[product_name] = price
  end

  def self.parser(row)
    products = {}

    split_by_item = row[1].split(";")
    split_by_item.each do |item_price|
      split_price = item_price.split(":")
      products[split_price[0]] = split_price[1].to_f
    end

    return products
  end

  def self.all
    order_data = CSV.read("data/orders.csv")

    orders = []

    order_data.each do |row|
      customer = Customer.find(row[2])
      order = Order.new(row[0].to_i, Order.parser(row), customer, row[3].to_sym)
      orders << order
    end

    return orders
  end

  def self.find(id)
    found_order = Order.all.find { |order| order.id == id.to_i }
    return found_order
  end 

end
