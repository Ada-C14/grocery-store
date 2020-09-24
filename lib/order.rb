class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  VALID_STATUSES = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    until VALID_STATUSES.include? @fulfillment_status
      raise ArgumentError.new("Sorry, that is not a valid fulfillment status.")
    end
  end

  def total
    cost = (@products.values.sum * 1.075).round(2)
    return cost
  end

  def add_product(name, price)
    if @products.has_key?(name)
      raise ArgumentError.new("Sorry, a product with the same name already exists.")
    else
      @products[name] = price
    end
  end

  def remove_product(name)
    if @products.has_key?(name)
      @products.delete(name)
    else
      raise ArgumentError.new("Sorry, that product cannot be found.")
    end
  end
end
