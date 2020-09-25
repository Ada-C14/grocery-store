class Order
  attr_reader(:order_id, :fulfillment_status)
  attr_accessor(:products, :costumer)

  VALID_STATUS = %i[pending paid processing shipped complete].freeze # add tips

  def initialize(order_id, products, customer, fulfillment_status = :pending) # add tips
    @order_id = order_id
    @products = products
    @customer = customer
    self.fulfillment_status = fulfillment_status
  end

  def fulfillment_status=(fulfillment_status) # the writer method
    validate_fulfillment_status(fulfillment_status)
    @fulfillment_status = fulfillment_status
  end

  def validate_fulfillment_status(fulfillment_status)
    unless VALID_STATUS.include? fulfillment_status
      raise ArgumentError, "Invalid status #{fulfillment_status}" # add to tips
    end
  end

  def total
    tax = 7.5/100.0
    total = @products.values.sum
    total_with_tax = total + (total * tax)
    return total_with_tax.round(2)
  end

  def add_product(product_name, price)
    if @products.include? product_name
      raise ArgumentError, "#{product_name} is already in products list"
    else
      @products[:product_name]= price
    end
  end

end