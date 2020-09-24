class Order

  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    raise ArgumentError if ![:pending, :paid, :processing, :shipped, :complete].include?(@fulfillment_status)

  end

  def total
    @total = (@products.values.sum * 1.075).round(2)
  end

  def add_product(product_name, price)
    if @products.key?(product_name)
      raise ArgumentError.new("This product already exist in the order.")
    else
      @products[product_name] = price
    end
  end

  def remove_product(product_name)
    if !@products.key?(product_name)
      raise ArgumentError.new("Couldn't find a product with that name.")
    else
      @products.delete(product_name)
    end
  end
end