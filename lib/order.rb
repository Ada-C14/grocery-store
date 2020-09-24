class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    statuses = %i[pending paid processing shipped complete]
    if !statuses.include?(fulfillment_status)
      raise ArgumentError.new("#{fulfillment_status} is an INVALID status.")
    end
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    sum = @products.values.sum
    tax = sum * 0.075
    total = (sum + tax).round(2)
    return total
  end

  def add_product(name, price)
    if @products.has_key?(name)
      raise ArgumentError.new("#{name} has already been added to the order")
    end
    @products[name] = price
  end
end