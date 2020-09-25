class Order

  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    # compared the fulfillment status against the acceptable statuses
    if %i[pending paid processing shipped complete].include? (fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError.new("#{fulfillment_status} is an invalid fulfillment status")
    end
  end

  # calculate the total cost of the order
  def total
    # products come in as a hash, item/price
    # extracts all of the values and sums them up
    cost = products.values.sum
    # add 7.5% tax and round to two decimal places
    total_cost = (cost * 1.075).round(2)
    return total_cost
  end

  def add_product(product_name, price)
    # raise error if there is a duplicate product
    if @products.keys.include?(product_name)
      raise ArgumentError.new('Item has already been added to the order')
    end

    # add product to the products hash
    @products[product_name] = price
  end

end

