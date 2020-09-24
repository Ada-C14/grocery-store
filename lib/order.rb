require_relative 'customer'
require 'csv'

class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    if !([:pending, :paid, :processing, :shipped, :complete].include?(@fulfillment_status))
      raise ArgumentError.new("Unknown fulfillment status")
    end

  end

  def total
    @total = (@products.values.sum * 1.075).round(2)
  end

  def add_product(product_name, price)
    if @products.has_key?(product_name)
      raise ArgumentError.new("Product is already in the order!")
    else
      @products[product_name] = price
    end
  end

  def remove_product(product_name)
    if @products.has_key?(product_name)
      @products.delete(product_name)
    else
      raise ArgumentError.new("No product with that name was found!")
    end

  end
end


# customer = Customer.new(111111, "aba@aba.com", {street_address:"111 Keen Way", city:"seattle", state:"WA", zip:98103})
#
# one = Order.new(1,{ "banana" => 1.99, "cracker" => 3.00 }, customer)
# p one.customer

# # p one.fulfillment_status
# one.add_product("boychow", 3.1)
# p one.products
# one.remove_product("banana")
# p one.products