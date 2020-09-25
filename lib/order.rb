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

    order_status = [:pending, :paid, :processing, :shipped, :complete]
    unless order_status.include?(@fulfillment_status)
      raise ArgumentError.new("invalid fulfillment status")
    end
  end

  def total
    product_total = @products.sum { |item, amount| amount }
    product_total *= 1.075
    product_total = ('%.2f' %product_total).to_f
    return product_total
  end

  def add_product(product_name, price)
    if @products.has_key?(product_name)
      raise ArgumentError.new("#{product_name} already listed")
    end
    @products[product_name] = price
    return @products
  end

  def remove_product(product_name)
    if @products.has_key?(product_name)
      @products.delete(product_name)
    else
      raise ArgumentError.new("#{product_name} not found")
    end

    return @products
  end

  def self.parse_product_data(info)
    product_data = info.split(";")
    product_data = Hash[ product_data.map { |item| item.split(":") }]
    product_data = Hash[ product_data.keys.zip(product_data.values.map(&:to_f))]
    return product_data
  end

  def self.all
    order_data = CSV.read("data/orders.csv").map do |info|
      self.new(
        info[0].to_i,
        parse_product_data(info[1]),
        Customer.find(info[-2].to_i),
        info[-1].to_sym
        )
    end
    # p order_data
    return order_data
  end

  def self.find(id)
    order_data = self.all
    order_by_id = order_data.find do |info|
      info if info.id == id
    end
    return order_by_id
  end

  def self.find_by_customer(customer_id)
    order_data = self.all
    orders_by_customer = order_data.select do |info|
      info if info.customer.id == customer_id
    end

    return nil if orders_by_customer.empty?
    return orders_by_customer
  end


end