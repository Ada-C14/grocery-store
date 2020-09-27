require 'csv'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)

    valid_fulfillments = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError, "invalid fulfillment status" unless valid_fulfillments.include?(fulfillment_status)

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

  end

  def add_product(product_name, price)
    raise ArgumentError, "duplicate product" if @products.key?(product_name) #if @products.include? also works!
    @products[product_name] = price
  end

  def total
    total = (@products.sum { |product_name, price| price } * 1.075).round(2)
    return total
  end

  #### WAVE 2 ####

  def self.all

    all_orders = []

    order_array = CSV.read('data/orders.csv')

    order_array.each do |order|

      id = order[0].to_i
      customer_id = order[2].to_i
      status = order[3].to_sym

      # HANDLING CUSTOMER ID
      customer = Customer.all.find { |customer| customer.id == customer_id }

      # HANDLING PRODUCTS
      # make a split array by ';' ["Lobster:17.18", "Annatto seed:58.38", "Camomile:83.21"]
      products_temp = order[1].split(';')

      # split further by ':' [["Lobster", "17.18"], ["Annatto seed", "58.38"], ["Camomile", "83.21"]]
      product_array = []
      products_temp.each do |product|
        product = product.split(':')
        product_array << product
      end

      # store those babies in a hash {"Lobster"=>17.18, "Annatto seed"=>58.38, "Camomile"=>83.21}
      product_hash = {}
      product_array.each do |product|
        product_hash[product[0]] = product[1].to_f
      end

      products = product_hash

      all_orders << Order.new(id, products, customer, status)

    end
    return all_orders
  end

  def self.find(id)
    order = self.all.find { |order| order.id == id }
    return order
  end

  # Wave 2 Optional
  def self.find_by_customer(customer_id)
    order_list = []
    self.all.each do |order|
      if order.customer.id == customer_id
        order_list << order
      end
    end
    return order_list
  end
end

