require_relative  './customer'

class Order
  attr_reader :ID

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    sum_with_tax = (@products.values.sum) * 1.075
     return sum_with_tax.round(2)
  end

  def add_product(name, price)
    if @products.any? (name)
      raise ArgumentError, 'That product already exists.'
    end
    new_product[name] = price
    product << new_product
  end
end