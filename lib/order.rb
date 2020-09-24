class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  SALES_TAX_RATE = 0.075

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    raise ArgumentError if ![:pending, :paid, :processing, :shipped, :complete].include?(@fulfillment_status)
  end

  def total
    if @products.empty?
      return 0
    else
      subtotal = @products.values.inject(:+)
      tax = SALES_TAX_RATE * subtotal
      total = (subtotal + tax).round(2)
      return total
    end
  end

  def add_product(product_name, price)
    if products.key?(product_name)
      raise ArgumentError
    else
      products[product_name] = price
    end
  end

  def remove_product(product_name)
    if !products.key?(product_name)
      raise ArgumentError
    else
      products.delete(product_name)
    end
  end
end