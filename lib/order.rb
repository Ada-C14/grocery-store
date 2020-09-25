require 'csv'
require_relative 'customer'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  VALID_STATUS = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    if VALID_STATUS.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError, "#{fulfillment_status} is not a valid status."
    end
  end

  def total
    tax = 0.075
    if products.empty?
      return 0
    else
      total_bill = (products.values.reduce(:+) * (1 + tax)).round(2)
      return total_bill
    end
  end

  def add_product(product_name, price)
    if products[product_name]
      raise ArgumentError, "This product already exists."
    else
      products[product_name] = price
    end
  end

  def remove_product(product_name)
    unless products.delete(product_name)
      raise ArgumentError, "This product does not exist, so it cannot be removed."
    end
  end

  def self.parse_products(products_in_order)
    products = {}
    products_in_order.split(';').each do |product|
      products[product.split(':')[0]] = product.split(':')[1].to_f
    end
    return products
  end

  def self.all
    all_orders = CSV.read('data/orders.csv').map { |row| row.to_a }

    all_orders = all_orders.map do |order|
      id = order[0].to_i
      products = self.parse_products(order[1])
      customer = Customer.find(order[2].to_i)
      fulfillment_status = order[3].to_sym
      Order.new(id, products, customer, fulfillment_status)
    end

    return all_orders
  end

  def self.find(id)
    order_found = self.all.select { |order| order.id == id }
    order_found.empty? ? (return nil) : (return order_found[0])
  end

  def self.find_by_customer(customer_id)
    customer_orders = self.all.select { |order| order.customer.id == customer_id }
    customer_orders.empty? ? (return nil) : (return customer_orders)
  end
end