require_relative 'customer.rb'
require "csv"

ORDER_STATUSES = [:pending, :paid, :processing, :shipped, :complete]

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status


  def initialize(id, products, customer, fulfillment_status = :pending) #id:number,items_w_cost:hash,address:hash
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    until ORDER_STATUSES.include?(fulfillment_status)
      raise ArgumentError, "Please enter a valid order status."
    end
  end

  def total
    pre_tax = @products.inject(0) { |sum, cost| sum += cost[1] }
    tax = pre_tax * 0.075
    total = pre_tax + tax.round(2)

    return total
  end

  def add_product(name, price)
    if @products.key?(name)
      raise ArgumentError, "Item already in order."
    else
      return @products[name] = price #add message that added to cart?
    end
  end

  def remove_product(name)
    if @products.key?(name)
      return @products.delete(name)
    else
      raise ArgumentError,  "Item not in order."
    end
  end

  def self.hash(products) #receives string of symbol key value pairs and returns string transformed to hash
    products_hash = {}
    split_products = products.split(";")

    split_products.each do |pair_product|
      split_products = pair_product.split(":")
      products_hash[split_products[0]] = split_products[1].to_f
    end

    return products_hash
  end

  def self.all
    all_orders_array = CSV.open("data/orders.csv", "r").map do |order_info|
      Order.new(order_info[0].to_i, self.hash(order_info[1]), Customer.find(order_info[2].to_i), order_info[3].to_sym) #cool thing makes
    end

    return all_orders_array
  end

  def self.find(id)
    self.all.each do |search_order|
      if search_order.id == id
        return search_order
      end
    end

    return nil
  end

  def self.find_by_customer(customer_id)
    customer_id.to_i

    list = self.all.select do |order|
      order.customer.id == customer_id
    end

    return list
  end

end

