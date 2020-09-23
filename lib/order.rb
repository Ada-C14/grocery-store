class Order

  def initialize(id, products, customer, fulfillment_status = :pending)

    raise ArgumentError.new("Invalid status") if !fulfillment_status.include?[:pending, :paid, :processing, :shipped, :complete]

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end
end