
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
    @products.each do |cost|
      value += cost

      value *= 0.075

    end
    return total
  end

  def add_prodcut(product_name, price)
    if @products.include?(product_name)
      raise ArgumentError #puts message here
    else
      @products[product_name]=price
    end
  end
  
end