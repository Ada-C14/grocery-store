require 'pry'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status =:pending )
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid_fulfillment = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError, "invalid status" unless valid_fulfillment.include?(fulfillment_status)
  end

  # method to calculate the total cost of the order
  def total
    total = (products.values.sum * 1.075).round(2)
    return total
  end

  #method to add the data to the product collection
  def add_product(product_name, price)
    @products[product_name] = price
    raise ArgumentError, "products already exit" if @products.include?(product_name)
  end
end

