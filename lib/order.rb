require 'csv'
require_relative '../lib/customer'
class Order

  attr_reader :fulfillment_status, :id, :products, :customer

  def initialize(id, products, customer, fulfillment_status = :pending)

    raise ArgumentError.new("Invalid status") if ![:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status)

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    if products.empty?
      return 0
    else
      sum = products.values.sum
      return  (sum + sum * 0.075).round(2)
    end
  end

  def add_product(product_name, price)
    raise ArgumentError.new("Duplicate products are not allowed") if @products.keys.include?(product_name)
    @products[product_name] = price
  end

  def remove_product(product_name)
    raise ArgumentError.new("Product not found") if !@products.keys.include?(product_name)

    @products.delete(product_name)
  end

  def self.all

    return CSV.parse(File.read("./data/orders.csv"), headers: [:id, :products, :customer_id, :status]).map do |row|
      Order.new(row[:id].to_i, to_products(row[:products]), Customer.find(row[:customer_id].to_i), row[:status].to_sym)
    end
  end

  def self.find(id)
    return self.all.find{|order| order.id == id}
  end

  def self.find_by_customer(customer_id)
    orders_with_cust = self.all.find_all{|order| order.customer.id == customer_id}
    return orders_with_cust.empty? ? nil : orders_with_cust
  end

  private

  def self.to_products(product_string)
    split_products = product_string.split(';')
    products = {}

    split_products.each {|split_prod_string| products[split_prod_string.match(/.*:/).to_s.delete(':')] = split_prod_string.match(/:.*/).to_s.delete(':').to_f}

    return products
  end
end