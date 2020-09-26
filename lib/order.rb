require_relative 'customer.rb'

class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    # check if fulfillment status is valid
    valid_statuses = %i[pending paid processing shipped complete]

    if valid_statuses.include?(@fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError
    end

  end

  def total
    if @products.empty?
      return 0
    else
      sum = @products.values.reduce(:+)
      sum_w_tax = (sum * 0.075) + sum
      return sum_w_tax.round(2)
    end
  end

  def add_product(product_name, price)
    if @products.key?(product_name)
      raise ArgumentError, 'Product already exists!'
    else
      @products[product_name] = price
    end
  end
end