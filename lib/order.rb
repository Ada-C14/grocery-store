require 'csv'
require_relative 'customer'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  VALID_STATUSES = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    raise ArgumentError.new("Invalid fulfillment status.") if ! VALID_STATUSES.include?(fulfillment_status)
    @fulfillment_status = fulfillment_status
  end

  def total
    total_cost = 0

    @products.each_value { |price| total_cost += price }

    total_cost *= 1.075
    return total_cost.round(2)
  end

  def add_product(product_name, price)
    raise ArgumentError.new("Product with that name has already been added to the order.") if @products.keys.include?(product_name)
    @products[product_name] = price
  end

  def remove_product(product_name)
    raise ArgumentError.new("Product with that name was not found.") if ! @products.keys.include?(product_name)
    @products.delete(product_name)
  end

  def self.to_products(product_list)
    products_hash = {}

    product_list.split(";").each { |product_cost_pair| products_hash[product_cost_pair.split(":").first] = product_cost_pair.split(":").last.to_f }

    return products_hash
  end

  def self.all
    orders_csv = CSV.read('data/orders.csv').map { |row| row.to_a }

    orders = orders_csv.map do |array|
      Order.new(array[0].to_i,
                Order.to_products(array[1]),
                Customer.find(array[2].to_i),
                array[3].to_sym)
    end

    return orders
  end

  def self.find(id)
    found_order = Order.all.find { |order| order.id == id }

    return found_order
  end

  def self.find_by_customer(customer_id)
    found_customer_orders = Order.all.find { |order| order.customer.id == customer_id }

    return found_customer_orders
  end
end
