require 'customer.rb'
require 'csv'

class Order

  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    if [:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError, "Invalid fulfillment status."
    end
  end


  def total
    return 0 if @products.empty?
    sum = @products.sum {|item, cost| cost}
    total = sum * 1.075
    return total.round(2)
  end

  def add_product(product_name, product_price)
    if @products.include?(product_name)
      raise ArgumentError, "This product is already included in our inventory."
    else
      @products[product_name] = product_price
    end
  end

  def remove_product(product_name, product_price)
    if @products.include?(product_name) == false
      raise ArgumentError, "This product is not in inventory."
    else @products.reject! {|key| key == product_name}
    end
  end

  def self.all
    cust_order = CSV.read('./data/orders.csv', headers: false).map do |row|
      id = row[0].to_i

      products = self.product_to_hash(row[1])

      customer = Customer.find(row[2].to_i)

      fulfillment_status = row[3] == nil ? nil : row[3].to_sym

      Order.new(id, products, customer, fulfillment_status)
    end
    return cust_order
  end

  def self.find(id)
    return self.all.find {|order| order.id == id }
  end

  private

  def self.product_to_hash(order_string)

    products = {}

    single_products = order_string.split(';')

    single_products.each do |product|
      hash_pair = product.split(':')
      products[hash_pair[0]] = hash_pair[1].to_f
    end

    return products

  end

end
