class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  FULFILLMENT_STATUS_ARRAY = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    if FULFILLMENT_STATUS_ARRAY.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError.new("Invalid fulfillment status")
    end

  end

  def total
    total_cost = 0
    @products.each_value {|value| total_cost += value}
    tax = total_cost * 0.075
    total_cost += tax
    return total_cost.round(2)
  end

  def add_product(product_name, price)
    current_product_names = @products.keys
    if current_product_names.include?(product_name)
      raise ArgumentError.new("This product has already been added to the order")
    else
      @products[product_name] = price
    end
    return @products
  end


end