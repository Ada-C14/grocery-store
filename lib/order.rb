require_relative './customer'

class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid_statuses = [:paid, :processing, :pending, :shipped, :complete]
    unless valid_statuses.include?(fulfillment_status)
      raise ArgumentError, "Not a valid fulfillment status."
    end
  end

  def total
    sum_with_tax = (@products.values.sum) * 1.075
    return sum_with_tax.round(2)
  end

  def add_product(name, price)
    if @products.key?(name)
      raise ArgumentError, 'That product already exists.'
    else
      return @products[name] = price
    end
  end

  def remove_product(name)
    if @products.key?(name)
      @products.delete(name)
    else
      raise ArgumentError, "Great news! That product isn't even in your cart."
    end

  end
end