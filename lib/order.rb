VALID_STATUS = [:pending, :paid, :processing, :shipped, :complete]
TAX = 0.075

class Order
  attr_reader :id, :customer, :fulfillment_status
  attr_accessor :products

  def initialize(id, products, customer, fulfillment_status = :pending)
    raise ArgumentError.new("Not a valid status.") if !VALID_STATUS.include?(fulfillment_status)

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end
end

