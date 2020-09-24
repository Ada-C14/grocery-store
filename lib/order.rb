require_relative 'customer'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    raise "id must be a number." if id < 1
    raise "products must be a hash" if products.class != Hash
    raise ArgumentError, "invalid fulfillment_status" unless [:pending, :paid, :processing, :shipped, :complete, nil].include? fulfillment_status

  end

  def total
    product_total = products.values.reduce(:+)
    product_total * 0.075
    total = format("$%.2f", product_total)
    return total
  end

  def add_product(product_name, price)
    
  end
end

kayla = Order.new(45678, {"milk" => 8, "sugar" => 10, "bread" => 2}, "Kayla")

pp kayla.total




# kayla_order = Order.new(4534, {}, "Kayla", :invalid)
# pp kayla_order