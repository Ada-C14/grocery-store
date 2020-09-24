class Order

  attr_reader :id, :product_list, :customer, :fulfillment_status

  def initialize
    @id = id
    @product_list = {}
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  # fulfillment status must be one of these symbols :pending, :paid, :processing, :shipped, or :complete
  # otherwise raise ArgumentError, "invalid fulfillment status"

  def total
    total = sum of product costs plus 7.5% sales tax, rounded to 2 decimal places
  end

  def add_product(product_name, price)
    @product_list[product_name] = price
  end

end