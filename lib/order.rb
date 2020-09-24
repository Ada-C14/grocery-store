class Order

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  # id, products, and customer are not writable
  attr_reader :id, :products, :customer

  attr_accessor :fulfillment_status

end