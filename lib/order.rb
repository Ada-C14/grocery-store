class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id_number, products, customer, fulfillment_status = :pending)
    @id = id_number
    @products = products
    @customer = customer
    @fulfillment_status = check_fulfillment_status(fulfillment_status)
  end

  def check_fulfillment_status(status)
    options = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError.new("This is not a valid fulfillment status") unless options.include?(status)
    return status
  end

  def total
    sum_total = @products.values.sum
    total_cost = (sum_total + (sum_total * 0.075)).round(2)
    return total_cost
  end

  def add_product(product_name, price)
    raise ArgumentError.new("This product is already in the collection") if @products.keys.include?(product_name.to_sym)
    @products[product_name.to_sym] = price
  end
end