require "csv"
require_relative "customer"

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id_number, products, customer, fulfillment_status = :pending)
    @id = id_number
    @products = products
    @customer = customer
    @fulfillment_status = check_fulfillment_status(fulfillment_status)
  end

  def check_fulfillment_status(status)
    options = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError.new("This is not a valid fulfillment status") unless options.include?(status)
    return status
  end

  def total
    sum_total = @products.values.sum
    total_cost = (sum_total + (sum_total * 0.075)).round(2)
    return total_cost
  end

  def add_product(product_name, price)
    raise ArgumentError.new("This product is already in the collection") if @products.keys.include?(product_name)
    @products[product_name] = price
    return @products
  end

  def remove_product(product_name)
    raise ArgumentError.new("This product isn't in the collection") unless @products.keys.include?(product_name)

    @products.delete(product_name)
    return @products
  end

  def self.create_hash(string)
    string = string.split(";")

    all_items = []
    string.each do |item|
      item_hash = {}
      # split item:price
      split_item = item.split(":")
      item_hash[split_item[0]] = split_item[1].to_f
      all_items.push(item_hash)
    end
    all_items = all_items.inject{|memo, obj| memo.merge(obj)}
    return all_items
  end

  def self.all

    # for rake
    orders = CSV.read("data/orders.csv")
    order_list = []
    # orders = CSV.read("../data/orders.csv")

    orders.each do |order|
      id_number = order[0].to_i
      products = order[1]
      customer = order[2].to_i
      fulfillment_status = order[3].to_sym
      order_list.push(Order.new(id_number, create_hash(products), Customer.find(customer), fulfillment_status))
    end
    return order_list
  end

  def self.find(id_number)
    order_list = Order.all
    return order_list.find{|order| order.id == id_number}
  end

  def self.find_by_customer(customer)
    order_list = Order.all
    return order_list.find_all{|order| order.customer.id == customer}

  end
end