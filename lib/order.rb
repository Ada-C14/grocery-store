require 'csv'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    valid_fulfillment_status = [:pending, :paid, :processing, :shipped, :complete]

    @id = id
    @products = products #hash { "banana" => 1.99, "cracker" => 3.00 }
    @customer = customer #instance of customer
    @fulfillment_status = fulfillment_status
    raise ArgumentError, "#{fulfillment_status} is not a valid status." if !valid_fulfillment_status.include?(fulfillment_status)
  end

  # Calculates the total cost of the order
  def total
    individual_costs = @products.values
    total_cost = individual_costs.sum
    taxed_total_cost = total_cost + total_cost * 0.075

    return taxed_total_cost.round(2)
  end

  # Method which will take in two parameters, product name and price,
  # and adds the data to the product collection
  def add_product(product_name, price)
    raise ArgumentError, "#{product_name} already exists in the order." if @products.include?(product_name)

    @products[product_name] = price
  end

  # Method which will take in one parameters, product name,
  # and removes the data to the product collection
  def remove_product(product_name)
    raise ArgumentError, "#{product_name} not found in order." unless @products.include?(product_name)

    @products.delete(product_name)
  end





end