VALID_STATUS = [:pending, :paid, :processing, :shipped, :complete]

class Order
  attr_reader :id, :customer, :fulfilment_status
  attr_accessor :products

  def initialize(id, products, customer, fulfilment_status = :pending)
    raise ArgumentError.new("Not a valid status.") if !VALID_STATUS.include?(fulfilment_status)

    @id = id
    @products = products
    @customer = customer
    @fulfilment_status = fulfilment_status
  end
end

