require_relative 'customer'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  @@order_all = nil

  TAX_RATE = 0.075

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    unless [:pending, :paid, :processing, :shipped, :complete].include? fulfillment_status
      raise ArgumentError
    end
  end

  def total
    return (@products.values.sum * (1 + TAX_RATE)).round(2)
  end

  def add_product(product_name, price)
    if @products.keys.include? product_name
      raise ArgumentError
    else
      @products.store(product_name,price)
    end
    return @products
  end

  def remove_product(product_name)
    if @products.keys.include? product_name
      @products.delete(product_name)
      return @products
    else
      raise ArgumentError
    end
  end

  def self.all
    unless @@order_all
      @@order_all = CSV.read("data/orders.csv")
                       .map {|row| Order.new(row[0].to_i,
                                             row[1].split(";").map {|item| item.split(":")}.to_h.transform_values {|v| v.to_f},
                                             Customer.find(row[2].to_i),
                                             row[3].to_sym)}
    end
    return @@order_all
  end

  def self.find_by_customer(customer_id)
    customer_matches = self.all.select {|order| order.customer.id == customer_id}
    return customer_matches
  end
end