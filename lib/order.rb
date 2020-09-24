class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  SALES_TAX = 0.075

  def initialize(id, products, customer, fulfillment_status = :pending)

    valid_fulfillments = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError, "invalid fulfillment status" unless valid_fulfillments.include?(fulfillment_status)

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

  end

  def add_product(product_name, price)
    raise ArgumentError, "duplicate product" if @products.include?(product_name)
    @products[product_name] = price
  end

  def total
    total = @products.sum { |product_name, price| price }
    total += (total * SALES_TAX)
    total = total.round(2)
    return total
  end

end