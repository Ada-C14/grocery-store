require_relative 'customer'
require 'csv'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    raise ArgumentError, "id must be a number." if id < 1
    raise ArgumentError, "products must be a hash" if products.class != Hash
    raise ArgumentError, "invalid fulfillment_status" unless [:pending, :paid, :processing, :shipped, :complete].include? fulfillment_status

  end

  def total
    if products.values.all? nil
      total = 0
      return total
    end
    product_total = products.values.reduce(:+)
    product_total = (product_total * 0.075) + product_total
    total = product_total.round(2)
    return total
  end

  def add_product(product_name, price)
    raise ArgumentError, "Product already exists in order" if products.has_key?(product_name)
    products.store(product_name, price)
  end

  def remove_product(product_name)
    raise ArgumentError, "That item doesn't exist in this order" unless products.has_key?(product_name)
    products.delete(product_name)
  end

  def self.all
    orders = []
    CSV.read('data/orders.csv').each do |row|
      order = parse_order(row)
      orders << order
    end
    return orders
  end

  def self.parse_order(row)
    products = row[1].split(';')
    products_hash = get_products_hash(products)
    customer = Customer.find(row[2].to_i)
    fulfillment_status = row[3].to_sym
    order = Order.new(row[0].to_i, products_hash, customer, fulfillment_status)
    return order
  end

  def self.get_products_hash(products)
    products_hash = {}
    products.each { |product| products_hash.store(product.split(':')[0] , product.split(':')[1].to_f ) }
    return products_hash
  end


  def self.find(id)
    order_data = Order.all
    order_data.each do |order|
      if order.id == id
        return  order
      end
    end
    puts "Sorry, this ID doesn't exist."
  end


  def self.find_by_customer(customer_id)
    orders_by_customer = []
    all_orders = Order.all
    all_orders.each do |order|
      if customer_id == order.customer.id
        orders_by_customer << order
      end
    end
    return orders_by_customer
  end


end
