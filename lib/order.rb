class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, product, customer, fulfillment_status = :pending)
    @id = id
    @products = product
    @customer = customer

    case fulfillment_status
    when :pending
      @fulfillment_status = :pending
    when :paid
      @fulfillment_status = :paid
    when :processing
      @fulfillment_status = :processing
    when :shipped
      @fulfillment_status = :shipped
    when :complete
      @fulfillment_status = :complete
    else
      raise ArgumentError.new("Invalid fulfillment status: #{ fulfillment_status }")
    end
  end

  def total
    return 0 if @products.count == 0
    sum = @products.values.reduce(:+) * 1.075
    return sum.round(2)
  end

  def add_product(name, price)
    raise ArgumentError.new("Invalid product: #{ name }") if @products.keys.include? (name)
    @products[name] = price
    return @products
  end

  def remove_product(rm_product)
    raise ArgumentError.new("Invalid product: #{ rm_product }") if !(@products.keys.include? (rm_product))
    return @products.slice!(rm_product)
  end
end