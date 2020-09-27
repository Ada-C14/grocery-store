require 'csv'
require 'awesome_print'

#CSV.read('planets_data.csv').map { |row| row.to_a } when not using headers

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = %i[pending paid processing shipped complete].include?(fulfillment_status) ? (fulfillment_status) : (raise ArgumentError)
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
end