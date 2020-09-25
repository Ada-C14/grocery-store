class Order

  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    # compared the fulfillment status against the acceptable statuses
    if %i[pending paid processing shipped complete].include? (fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError.new("#{fulfillment_status} is an invalid fulfillment status")
    end
  end

  # create a total method which will calculate the total cost of the order
  def total
    # sum up the products
    # products come in as a hash, item/ price
    cost = products.values.sum
    # add 7.5% tax
    total_cost = (cost * 1.075).round(2)
    # round to two decimal places
    return total_cost
  end

end

