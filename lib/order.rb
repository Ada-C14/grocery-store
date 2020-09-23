class Order
  attr_reader :fulfillment_status, :id, :products, :customer
  def initialize(id, products, customer, fulfillment_status = :pending)

    raise ArgumentError.new("Invalid status") if ![:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status)

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    if products == {}
      return 0
    else
      sum = products.values.sum
      return  (sum + products.values.sum * 0.075).round(2)
    end

  end
end