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

    raise ArgumentError.new("Invalid fulfillment status. #{fulfillment_status}") unless [:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status)
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
    orders =[]
    CSV.read('data/orders.csv').each do |row|
      product_hash = {}
      row[1].split(";").each do |item|
        product, price = item.split(":")
        product_hash[product] = price.to_f
      end
      order_info = self.new(row[0].to_i, product_hash, Customer.find(row[2].to_i), row[3].to_sym)

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

  def self.find_by_customer(customer_id)
    all_orders = self.all
    all_orders.each do |order|
    if customer_id == order.customer.id
      return order
    end
    end
    return nil
  end

end

