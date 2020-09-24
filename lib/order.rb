class Order
  attr_reader :id

  def initialize(id, products_and_prices, customer, fulfillment_status = :pending)
    statuses = %i[pending paid processing shipped complete]
    if !statuses.include?(@fulfillment_status)
      raise ArgumentError, "#{@fulfillment_status} is an INVALID status."
    end
    @id = id
    @products_and_prices = products_and_prices
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    sum = @products_and_prices.values.sum
    tax = sum * 0.75
    total = (sum + tax).round(2)
    return total
  end
end