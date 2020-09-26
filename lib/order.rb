require 'pry'
require 'money'
require_relative 'customer'

class Order

  attr_reader :id

  attr_accessor :products,:customer, :fulfillment_status

  def validate_fulfillment_status(fulfillment_status)
    valid_ful_status = [:pending, :paid, :processing, :shipped, :complete]
    if !(valid_ful_status.include?(fulfillment_status))
      raise ArgumentError.new("#{fulfillment_status} is an invalid option for the Fulfillment Status.")
    else return true
    end
  end

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products #{"product" => cost, "product2" => cost}
    @customer = customer
    @fulfillment_status = fulfillment_status

    validate_fulfillment_status(fulfillment_status)
  end

  def total
    # sum = products.values.inject(0)(:+)
    sum = @products.values.inject(0) { |sum, cost| sum + cost }
    tax_rate = 0.075
    unrounded_order_cost = sum + (sum * tax_rate)
    rounded_order_cost = unrounded_order_cost.round(2)
    return rounded_order_cost
  end

  def add_product(product_name, price)
    if @products.keys.include?(product_name)
      raise ArgumentError.new ("#{product_name} is already in the collection!")
    end
    @products[product_name] = price
    return @products
  end

  def remove_product(product_name)
    if !(@products.keys.include?(product_name))
      raise ArgumentError.new ("#{product_name} isn't in the collection!")
    else @products.delete(product_name)
    return @products
    end
  end

  def self.all
    orders = CSV.read('data/orders.csv').map do |row|
      Order.new(row[0].to_i, # id
                self.products_to_hash(row[1]), # calls helper method
                   row[2], # customer
                   row[3].to_s # fulfillment_status
      )
    end
    return orders
  end

  # def self.find(id)
  #   self.all.find { |customer| customer.id == id}
  # end

  private

  def self.products_to_hash(products_string)
    products_hash = Hash.new
    products_string.split(";").each do |string| # line returns [ product1:price1, product2:price2 ]
    product = string.split(":")[0]
    price = string.split(":")[1]
    products_hash[product] = price
    end
    return products_hash
  end

end