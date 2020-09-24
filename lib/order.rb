class Order
  attr_reader :id
  attr_accessor :products

  def initialize(customer, fulfillment_status)
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total

  end

  def add_product

  end

end