class Order
  attr_reader :fulfillment_status, :id, :products, :customer
  def initialize(id, products, customer, fulfillment_status = :pending)

    raise ArgumentError.new("Invalid status") if ![:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status)

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    if products.empty?
      return 0
    else
      sum = products.values.sum
      return  (sum + sum * 0.075).round(2)
    end
  end

  def add_product(product_name, price)
    raise ArgumentError.new("Duplicate products are not allowed") if @products.keys.include?(product_name)
    @products[product_name] = price
  end

  def remove_product(product_name)
    raise ArgumentError.new("Product not found") if !@products.keys.include?(product_name)
    @products.delete(product_name)
  end

end