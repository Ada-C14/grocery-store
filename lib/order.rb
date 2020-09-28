require 'customer'

class Order
  attr_reader :id, :customer
  attr_accessor :products, :fulfillment_status

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
end