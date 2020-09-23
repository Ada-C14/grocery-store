class Order
  attr_reader :fulfillment_status, :id, :products, :customer
  def initialize(id, products, customer, fulfillment_status = :pending)

    raise ArgumentError.new("Invalid status") if ![:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status)

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end
end