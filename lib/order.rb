class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  VALID_STATUS = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    if VALID_STATUS.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError, "#{fulfillment_status} is not a valid status."
    end
  end

  def total
    tax = 0.075
    if products.empty?
      return 0
    else
      total_bill = (products.values.reduce(:+) * (1 + tax)).round(2)
      return total_bill
    end
  end

  def add_product(product_name, price)
    if products[product_name]
      raise ArgumentError, "This product already exists."
    else
      products[product_name] = price
    end
  end
end