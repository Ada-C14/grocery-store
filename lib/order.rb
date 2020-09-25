require_relative './customer'
require 'csv'

class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid_statuses = [:paid, :processing, :pending, :shipped, :complete]
    unless valid_statuses.include?(fulfillment_status)
      raise ArgumentError, "Not a valid fulfillment status."
    end
  end

  def total
    sum_with_tax = (@products.values.sum) * 1.075
    return sum_with_tax.round(2)
  end

  def add_product(name, price)
    if @products.key?(name)
      raise ArgumentError, 'That product already exists.'
    else
      return @products[name] = price
    end
  end

  def remove_product(name)
    if @products.key?(name)
      @products.delete(name)
    else
      raise ArgumentError, "Great news! That product isn't even in your cart."
    end

  end

  def self.all
    all = []

    csv = CSV.read('data/orders.csv')
    csv.each do |data|
      id = data[0].to_i

      products = {}
      product_split = data[1].split(%r{;\s*})
      product_split.each do |pair|
        key, value = pair.split(/:/)
        products[key] = value.to_f
      end

      customer = Customer.find(data[2].to_i)

      status = data[3].to_sym

      all << Order.new(id, products, customer, status)
    end
    return all
  end

  def self.find(id)
    Order.all.find {|order| order.id == id}
  end

  def self.find_by_customer(customer_id)
    Order.all.find.each_with_object([]) {|order| order.customer == customer_id}
  end
end