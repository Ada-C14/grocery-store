require 'csv'
# require 'awesome_print'

require_relative 'customer'

#helper method
def string_to_hash(string)
  hash = string.split(/;/).map { |pair| pair.split(/:/) }.to_h
  return hash.each { |key, value| hash[key] = value.to_f if value =~ /\d+/ }
end

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    valid_status = %i[pending paid processing shipped complete]
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = valid_status.include?(fulfillment_status) ? (fulfillment_status) : (raise ArgumentError)
  end

  def total
    sum = products.values.reduce(:+)
    products == {}? 0 : (sum * 0.075 + sum).floor(2)
  end

  def add_product(product_name, price)
    products.include?(product_name) ? (raise ArgumentError) : (products[product_name] = price)
  end

  def self.all
    # - `self.all` - returns a collection of `Order` instances, representing all of the Orders described in the CSV file
    modified_csv_data = CSV.read('./data/orders.csv').map do |order|
      Order.new(order[0].to_i,
                string_to_hash(order[1]),
                Customer.find(order[2].to_i),
                order[3].to_sym)
    end

    return modified_csv_data
  end

  def self.find(id)
    order_found = Order.all.select { |order| order.id == id ? order : nil }[0]
    return order_found
  end

  # ap Order.all.last.fulfillment_status
  # ap Order.find(36)
  # 1. Parse the list of products into a hash
  #     - This would be a great piece of logic to put into a helper method
  #     - You might want to look into Ruby's `split` method
  #     - We recommend manually copying the first product string from the CSV file and using pry to prototype this logic
end