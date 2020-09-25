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
    if @products.has_key?(product_name)
      raise ArgumentError.new("#{product_name} already listed")
    end
    @products[product_name] = price
    return @products
  end

  def remove_product(product_name)
    if @products.has_key?(product_name)
      @products.delete(product_name)
    else
      raise ArgumentError.new("#{product_name} not found")
    end

    return @products
  end

end