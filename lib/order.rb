
class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  VALID_ORDER = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer, fulfillment_status =:pending)
    @id = id
    @products = products
    @customer = customer
    if VALID_ORDER.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError #puts a statement here?
    end
  end

  def total
    value = 0
    @products.each do |item, cost|
      value += cost

    end

    return (value * 1.075).round(2)
  end

  def add_product(product_name, price)
    if @products.include?(product_name)
      raise ArgumentError #puts message here
    else
      @products[product_name]=price
    end
  end

end