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

end

kaylas_order = Order.new(4534, {}, "Kayla", :paid)
pp kaylas_order