require "csv"

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products = {}, customer = nil, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    if ![:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status)
      raise ArgumentError.new("Invalid Status: #{@fulfillment_status}. Must be one of the following: pending, paid, processing, shipped, or complete.")
    end

    @fulfillment_status = fulfillment_status
  end

  def total
    sum = 0
    total = 0

    @products.each do |key, value|
      sum += value
    end

    total = sum + sum * 0.075

    return total.round(2)
  end

  def add_product(product_name, price)
    # @products.each do |key, value|
    #   if key == product_name
    #     raise ArgumentError.new("{#{product_name} already added.")
    #   end

    # can replace each loop with:
    if @products.keys.include?(product_name)
      raise ArgumentError.new("{#{product_name} already added.")
    end
    # end

    @products[product_name] = price
  end
end
