#

class Order
  attr_reader :id
  attr_accessor :product_collection, :customer, :fulfillment_status

  def initialize
    @id = id
    @product_collection = {}
  end

  # Create product collection, array of hashes
  #
  # def total(order_products)
  #   return
  #   Each order * its price
  #   Sum all this
  #   Multiply by 1.075
  #   Round this to 2 decimal places
  # end

  # Problem of accessing product_collection array from outside method
  def add_product(product_name, price)
    product_hash = {}
    product_hash[product_name] = price
    @product_collection << product_hash
  end

  pp add_product("banana", 1.99)

end