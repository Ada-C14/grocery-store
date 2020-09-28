require_relative "customer"
require 'csv'

class Order

  attr_reader :id

  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products #hash with "item" => price
    @customer = customer #instannce of customer class
    @fulfillment_status = fulfillment_status

    check_status(fulfillment_status)
  end

  # #not sure if this is how i should do this,,I'm thinking not => does not work
  def check_status(fulfillment_status)
    valid_status = [:pending, :paid, :processing, :shipped, :complete]
    if valid_status.include?(fulfillment_status) == false
      raise ArgumentError.new("not a valid shipping status")
    else
      return true
    end
  end
  # this sort of works? wont puts out the hash though
  def add_product(name, price)
    if @products.key?(name)
      raise ArgumentError.new("invalid entry")
    else
      @products[name] = price
    end
  end
  #not a priority
  # def remove_product(product)
  #   #argument error if product does not match any key, value pair
  #   product#find product key,value pair and remove from hash
  # end
  #this works
  def total
    total = (@products.values.sum * 1.075).round(2)

    return total
  end

  def self.parse_to_hash(products_string)
    products = {}
    products_string.split(/;/).each do |product_string|
      product, price = product_string.split(/:/)
      products[product] = price.to_f
    end
    return products
  end

  def self.all
    all_orders = []
    CSV.read('data/orders.csv').map { |row| row.to_a }.each do |order|

      id = order[0].to_i
      products = Order.parse_to_hash(order[1])
      customer = Customer.find(order[2].to_i)
      status = order[3].to_sym
      all_orders << Order.new(id, products, customer, status)
    end
    return all_orders
  end

  def self.find(id)
    orders = self.all
    orders.each do |order|
      if order.id == id
        return order
      end
    end
    return nil
  end

end

