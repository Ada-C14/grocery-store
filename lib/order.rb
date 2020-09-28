require 'csv'
require_relative 'customer'
class Order

  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    # compared the fulfillment status against the acceptable statuses
    if %i[pending paid processing shipped complete].include? (fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError, "#{fulfillment_status} is an invalid fulfillment status"
    end
  end

  # calculate the total cost of the order
  def total
    # extracts all of the values from the hash and sums them up
    cost = @products.values.sum
    # add 7.5% tax and round to two decimal places
    return (cost * 1.075).round(2)
  end

  def add_product(product_name, price)
    # raise error if there is a duplicate product
    if @products.keys.include?(product_name)
      raise ArgumentError, 'Item has already been added to the order'
    end

    # add product to the products hash
    @products[product_name] = price
  end

  def remove_product(product_name)
    # initial count of products
    before_count = @products.count

    # creates a new hash selecting all product except for the one to remove
    new_list = @products.select { |product, cost| product != product_name}

    # the new list count should be one less than the initial count
    if new_list.count == before_count - 1
      @products = new_list
    else
      raise ArgumentError.new("#{product_name} was not found!")
    end
  end

  # helper method for the Order.all method
  # takes the products from the CSV file and formats it into a hash
  # the key is the item
  # the value is the price
  def self.products_hash_format(products_to_split)
    products = products_to_split.split(';')
    products_hash = {}

    products.each do |product|
      product_array = product.split(':')
      products_hash[product_array[0]] = product_array[1].to_f
    end

    return products_hash
  end

  def self.all
    # reads the orders.csv and formats each row into a hash
    orders = CSV.read('data/orders.csv', headers: true).map do |row|
      row.to_h
    end

    # creates a new Order instance for each order in the CSV file
    return orders.map do |order|
      # invokes the products to hash method to reformat the products
      products = products_hash_format(order["products"])
      customer = Customer.find(order["customer_id"].to_i)

      Order.new(order["id"].to_i, products, customer, order["status"].to_sym)
    end
  end

  # iterates through all of the orders to find the matching ID
  # no match would return nil
  def self.find(id)
    return self.all.find { |order| order.id == id}
  end

  # returns a list of Order instances
  # where the value of the customer's ID matches passes parameter
  def self.find_by_customer(customer_id)
    return self.all.select { |order| order.customer.id == customer_id}
  end
end




