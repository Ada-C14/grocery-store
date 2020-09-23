class Order
  attr_reader :id # WELP, HAD TO MAKE ASSUMPTIONS FOR THE REST...
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status=:pending)
    @id = id
    @products = products # products collection data
    @customer = customer
    @fulfillment_status = fulfillment_status

    acceptable_fulfillment_status = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError.new("status must be pending, paid, processing, shipped or complete") unless acceptable_fulfillment_status.include?(fulfillment_status)
  end

  def total
    cost_sum = 0
    products.sum {|k,v| cost_sum += v}
    output = (cost_sum * 1.075).round(2)
    return output
    # sums all the values contained in products
    # then add 7.5% tax
    # round to two decimals
  end

  def add_product(name, price)
    raise ArgumentError.new("Product already exists") if @products.has_key?(name)
    @products[name] = price
  end
end