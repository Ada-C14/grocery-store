require_relative 'customer'
require 'csv'

class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    raise ArgumentError if ![:pending, :paid, :processing, :shipped, :complete].include?(@fulfillment_status)
  end

  def total
    @total = (@products.values.sum * 1.075).round(2)
  end

  def add_product(product_name, price)
    if @products.key?(product_name)
      raise ArgumentError.new("This product already exist in the order.")
    else
      @products[product_name] = price
    end
  end

  def remove_product(product_name)
    if !@products.key?(product_name)
      raise ArgumentError.new("Couldn't find a product with that name.")
    else
      @products.delete(product_name)
    end
  end

  def self.all
    orders_raw = CSV.read('data/orders.csv')

    all_orders = orders_raw.map do |order|

      products = order[1].split(';').map{ |pair|
        key, value = pair.split(':')
        { key => value.to_f } }.reduce({}, :merge)

      Order.new(order[0].to_i, products, Customer.find(order[2].to_i), order[3].to_sym)
    end

    return all_orders
  end

  def self.find(id)
    return self.all.find{|order| order.id == id}
  end

  def self.find_by_customer(customer_id)
    return self.all.select { |order| order.customer.id == customer_id }
  end

end