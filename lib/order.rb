require 'csv'
require 'customer'

class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    raise ArgumentError unless [:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status)

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    total_cost = 0
    @products.each_value { |price| total_cost += price }
    final_cost = total_cost * 1.075
    return final_cost.round(2)
  end

  def add_product(product_name, price)
    raise ArgumentError if @products.has_key?(product_name)
    @products[product_name] = price
  end

  def self.parse(products)
    product_hash = {}
    products.split(";").each do |item|
      details = item.split(":")
      product_hash[details[0]] = details[1].to_f
    end
    return product_hash
  end

  def self.all
    orders = CSV.read('data/orders.csv').map do |row|
      Order.new(row[0].to_i,
                parse(row[1]),
                Customer.find(row[2].to_i),
                row[3].to_sym)
    end
    return orders
  end

  def self.find(id)
    return self.all.find{|order| order.id == id}
  end
end