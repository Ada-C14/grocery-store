class Order

  def initialize(id, products, customer, fulfillment_status = :pending)
    legal_fulfillment_statuses = [:pending, :paid, :processing, :shipped, :complete]
    if !legal_fulfillment_statuses.include?(fulfillment_status)
      raise ArgumentError.new("invalid fulfillment status")
    end

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  # id, products, and customer are not writable
  attr_reader :id, :products, :customer

  attr_accessor :fulfillment_status

  def total
    if products.length == 0
      return 0
    else
      total_cost = products.sum { |item, price| price }
      total_cost *= 1.075
      return total_cost.round(2)
    end
  end

end