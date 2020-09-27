require_relative 'customer.rb'
require 'csv'

def product_format(string)
  formatted = Hash.new(0)

  products_split = string.split(';')

  products_split.each do |product|
    cost_split = product.split(':')
    formatted[cost_split[0]] = cost_split[1].to_f
  end

  return formatted
end


class Order
  def initialize (id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
      status_options = [:pending, :paid, :processing, :shipped, :complete]
      raise ArgumentError.new("Not a valid fulfillment status.") if status_options.include?(fulfillment_status) == false
  end

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def total
    subtotal = 0.00
    @products.each do |product, cost|
      subtotal += cost
    end

    subtotal *= 1.075
    total = subtotal.round(2)

    return  total
  end

  def add_product(name, price)
    if @products.include? name
      raise ArgumentError
    else @products[name] = price
    end
  end

  def self.all
    orders_temp = CSV.read('data/orders.csv').map do |row|
      { "id" => row[0].to_i,
        "products" => product_format(row[1]),
        "customer id" => row[2].to_i,
        "status" => row[3].to_sym
      }
    end

    orders = []
    orders_temp.each do |row|
      orders << Order.new(row["id"], row["products"], Customer.find(row["customer id"]), row["status"])
    end

    return orders
  end

  def self.find(id)
    found = Order.all.select { |order| order.id == id }

    return found[0]
  end

end