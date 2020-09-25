class Order
  attr_reader :id
  attr_accessor :products, :customer, :status

  TAX_RATE = 0.075

  def initialize(id, products, customer)
    @id
    @products
    @customer
    @status = :pending
  end

  def total
    return (@products.values.sum * (1 + TAX_RATE)).round(2)
  end

  def add_product(product_name, price)
    if @products.keys.inclued? product_name
      raise ArgumentError
    else
      @products << {product_name => price}
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