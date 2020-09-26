class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @tax = 1.075
    @allowable_statuses = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError.new("ID must be a number") unless id.class == Integer
    @id = id
    raise ArgumentError.new("Products must be a hash") unless products.class == Hash
    @products = products
    unless customer.class == Customer
      raise ArgumentError.new("Customer must be instance of Customer class")
    end
    @customer = customer
    unless @allowable_statuses.include?(fulfillment_status)
      string = "fulfullment status invalid\n Must be one of the following: "
      @allowable_statuses.each { |status| string < status.to_s }
      raise ArgumentError.new(string)
    end
    @fulfillment_status = fulfillment_status
  end

  def total
    return (products.values.sum * @tax).round(2)
  end

  def add_product(product_name, price)
    raise ArgumentError.new("Product already exists") if @products.has_key?(product_name)
    @products[product_name] = price
  end
end