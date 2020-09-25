class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  TAX_RATE = 0.075

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    unless [:pending, :paid, :processing, :shipped, :complete].include? fulfillment_status
      raise ArgumentError
    end
  end

  def total
    return (@products.values.sum * (1 + TAX_RATE)).round(2)
  end

  def add_product(product_name, price)
    if @products.keys.include? product_name
      raise ArgumentError
    else
      @products.store(product_name,price)
    end
    return @products
  end

  def remove_product(product_name)
    if @products.keys.include? product_name
      @products.delete(product_name)
      return @products
    else
      raise ArgumentError
    end
  end
end