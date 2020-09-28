require 'pry'
require 'csv'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status =:pending )

    # check the validation of the status
    valid_fulfillment = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError.new("invalid status") unless valid_fulfillment.include?(fulfillment_status)

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  # method to calculate the total cost of the order
  def total
    return  0 if @products.empty?
    total = (@products.sum { |name, price| price } * 1.075).round(2)
    return total
  end

  # method to add the data to the product collection
  def add_product(product_name, price)
    raise ArgumentError.new ("products already added") if @products.include?(product_name)
    @products[product_name] = price
  end


  # helper method to create a product hash
  # products = name:price;nextname:nextprice
  def self.product_hash(products)
    product = {}
    product_arr = products.split(";")

    product_arr.each do |i|
      # [["Lobster", "17.18"], ["Annatto seed", "58.38"], ["Camomile", "83.21"]]
      items-arr = i.split(":")
      #assign key & value to the hash(product)
      product[items-arr[0]] = items-arr[1].to_f
    end
    return product
  end

  # a method that returns a collection of Order instances
  def self.all
    order_arr = CSV.read('data/orders.csv').map do |order|
      id = order[0].to_i
      products = product_hash(order[1])
      customer = Customer.find(order[2].to_i)
      status = order[3].to_sym

      Order.new(id, products, customer, status)
    end
    return order_arr
  end

  def self.find(id)
    order = all.find { |order| order.id == id  }
    return order
  end
end

