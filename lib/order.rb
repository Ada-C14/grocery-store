
class Order

  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    if [:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError, "Invalid fulfillment status."
    end
  end


  def total
    return 0 if @products.empty?
    sum = @products.sum {|item, cost| cost}
    total = sum * 1.075
    return total.round(2)
  end

end
