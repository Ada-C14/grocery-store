VALID_STATUS = [:pending, :paid, :processing, :shipped, :complete]
TAX = 0.075

class Order
  attr_reader :id, :customer, :fulfillment_status
  attr_accessor :products

  def initialize(id, products, customer, fulfillment_status = :pending)
    raise ArgumentError.new("Not a valid status.") if !VALID_STATUS.include?(fulfillment_status)

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    subtotal = @products.sum { |product, price| price }
    tax = subtotal * TAX
    total = subtotal + tax

    return total.round(2)
  end

  def add_product(product_name, price)
    if @products.has_key?(product_name)
      raise ArgumentError.new("Product already exists.")
    else
      @products[product_name] = price
    end
  end

  def remove_product(product_name)
    if @products.has_key?(product_name)
      @products.delete(product_name)
    else
      raise ArgumentError.new("That product does not exist.")
    end
  end
end

