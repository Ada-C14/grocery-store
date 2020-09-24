require_relative 'customer'

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

end

# kayla = Order.new(45678, {"bread" => 5, "meat" => 7}, "Kayla")
# kayla.remove_product("olives")
# pp kayla



# kayla_order = Order.new(4534, {}, "Kayla", :invalid)
# pp kayla_order