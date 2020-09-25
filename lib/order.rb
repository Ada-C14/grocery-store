require_relative 'customer.rb'
require 'csv'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  SALES_TAX = 0.075

  def initialize(id, products, customer, fulfillment_status = :pending)

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    raise ArgumentError.new("Invalid fulfillment status.") if [:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status) != true
  end

  def total
    if products.empty?
      return 0
    else
      cart_total = @products.values.inject(:+)
      tax = SALES_TAX * cart_total
      total = (cart_total + tax).round(2)
    end
    return total
  end

  def add_product(name, price)
    if @products.key?(name)
      raise ArgumentError.new("Product already exists")
    else
      @products[name] = price
    end
  end

  def remove_product(name)
    if @products.key?(name)
      @products.delete(name)
    else
      raise ArgumentError.new("Product not found")
    end
    return @products
  end

  def self.all
    orders = CSV.read('data/orders.csv').each do |row|
      order_info = self.new(row[0], row[1], Customer.find(row[2]), row[3])

      orders << order_info
    end
    return orders
  end

  def self.find(id)
    all_orders = self.all
    all_orders.each do |order|
      if id == order.id
        return order
      end
    end
    return nil
  end


end

