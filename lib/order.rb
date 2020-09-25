class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    order_status = [:pending, :paid, :processing, :shipped, :complete]
    unless order_status.include?(@fulfillment_status)
      raise ArgumentError.new("invalid fulfillment status")
    end
  end

  def total
    product_total = @products.sum { |item, amount| amount }
    product_total *= 1.075
    product_total = ('%.2f' %product_total).to_f
    return product_total
  end

  def add_product(product_name, price)
    unless @products.has_key?(product_name)
      @products[product_name] = price
    else
      raise ArgumentError.new("Product already exists!")
    end

    return @products
  end

end