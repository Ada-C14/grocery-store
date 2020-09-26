class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    error_1(@fulfillment_status)
  end

  def error_1(fulfillment_status)
    statuses = [:pending, :paid, :processing, :shipped, :complete]
    if statuses.include?(fulfillment_status) == false
      raise ArgumentError
    end
  end

  def total
    if @products.empty?
      return 0
    else
      total = (@products.values.sum * 1.075).round(2)
    end
    return total
    # A total method which will calculate the total cost of the order by:
    # Summing up the products
    # Adding a 7.5% tax (*.175) = total + sales tax
    # Rounding the result to two decimal places (.round(2))
  end

  def add_product(product_name, price)
    if @products.key?(product_name)
      raise ArgumentError.new("Unaccepted input. Product already exists.")
    end
    return @products[product_name] = price
  end

end