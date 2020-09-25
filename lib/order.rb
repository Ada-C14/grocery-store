class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  # Constructor
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    status_validation(fulfillment_status)
    @fulfillment_status = fulfillment_status
  end

  def status_validation(fulfillment_status)
    case fulfillment_status
    when :pending, :paid, :processing, :shipped, :complete
      return fulfillment_status
    else
      raise ArgumentError, 'The status is invalid'
    end
  end

  def total
    sum = 0
    @products.each do |product, cost|
      sum += cost
    end
    tax_amount = 0.075 * sum
    total = sum + tax_amount

    return  total.round(2)

  end

  def add_product(product_name, price)
    if @products.has_key?(product_name)
      raise ArgumentError, 'The product is already added to the order'
    end

    # Adding a pair of product and price to the product hash
    @products[product_name] = price

    return @products

  end
end