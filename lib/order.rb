require 'csv'
require 'awesome_print'

require_relative 'customer'

#CSV.read('planets_data.csv').map { |row| row.to_a } when not using headers

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

  #  Optional Enhancements
    # Make sure to write tests for any optionals you implement!
    # Add a remove_product method to the Order class which will take in one parameter, a product name, and remove the product from the collection
      # If no product with that name was found, an ArgumentError should be raised

  def self.all
    # - `self.all` - returns a collection of `Order` instances, representing all of the Orders described in the CSV file
    modified_csv_data = CSV.read('../data/orders.csv').map do |order|
      Order.new(order[0].to_i,
                order[1].split(/;/).map { |pair| pair.split(/:/) }.to_h,
                Customer.find(order[2].to_i),
                order[3].to_sym)
    end

    return modified_csv_data
  end

  def self.find(id)
    # - `self.find(id)` - returns an instance of `Order` where the value of the id field in the CSV matches the passed parameter
    # As before, `Order.find` should call `Order.all` instead of loading the CSV file itself.
    order_found = Order.all.select { |order| order.id == id ? order : nil }[0]
    return order_found
  end

  ap Order.all
  ap Order.find(33)
  # 1. Parse the list of products into a hash
  #     - This would be a great piece of logic to put into a helper method
  #     - You might want to look into Ruby's `split` method
  #     - We recommend manually copying the first product string from the CSV file and using pry to prototype this logic
  # 1. Turn the customer ID into an instance of `Customer`
  #     - Didn't you just write a method to do this?
end