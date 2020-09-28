require 'csv'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  FULFILLMENT_STATUS_ARRAY = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    if FULFILLMENT_STATUS_ARRAY.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError.new("Invalid fulfillment status")
    end

  end

  def total
    total_cost = 0
    @products.each_value {|value| total_cost += value}
    tax = total_cost * 0.075
    total_cost += tax
    return total_cost.round(2)
  end

  def add_product(product_name, price)
    current_product_names = @products.keys
    if current_product_names.include?(product_name)
      raise ArgumentError.new("This product has already been added to the order")
    else
      @products[product_name] = price
    end
    return @products
  end

  def self.all
    return CSV.read('data/orders.csv').map do |row|
      id = row[0].to_i
      products_string = row[1].split(';')
      products_hash = {}
      products_string.each do |product|
        item = product.split(':')
        name = item[0]
        price = item[1].to_f
        products_hash[name] = price
      end
      products = products_hash
      customer = Customer.find(row[2].to_i)
      fulfillment_status = row[3].to_sym
      Order.new(id, products, customer, fulfillment_status)
    end
  end

  def self.find(id)
    return self.all.find { |customer| customer.id == id}
  end

end