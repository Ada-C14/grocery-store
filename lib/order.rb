class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize (id, products, customer, fulfillment_status = :pending )
    # REMEMBER: to set default value do ()fulfillment_status = :pending) in the params of the initialize method
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    # raise Argument error if fulfillment status is not the valid symbols
    until %i[pending paid processing shipped complete].include?(@fulfillment_status)
      raise ArgumentError.new("invalid fullfillment status")
    end
  end

  def total
    return 0 if @products.empty?

    products_total = @products.map { |product, cost| cost }.sum
    final_total = (products_total * 1.075).round(2)
    return final_total
  end

  def add_product(name, price)
    raise ArgumentError.new("We already have that product name") if @products.has_key?(name)
    @products[name] = price
  end

  #optional remove_product method
  def remove_product(name)
    raise ArgumentError.new("No product with that name was found") if @products.has_key?(name) == false
    @products.delete(name)
    return @products

  end


end