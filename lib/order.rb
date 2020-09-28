require 'csv'
require_relative 'customer'

class Order
  # Getter method return :int_id, @int_id value when calls
  attr_reader :id, :products, :customer, :fulfillment_status

  # Constructor
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    status_validation(fulfillment_status)
    @fulfillment_status = fulfillment_status
  end

  # Helper method
  def status_validation(fulfillment_status)
    case fulfillment_status
    when :pending, :paid, :processing, :shipped, :complete
      return fulfillment_status
    else
      raise ArgumentError, 'The sym_status is invalid'
    end
  end

  def total
    sum = 0
    tax_rate = 0.075
    @products.each do |product, cost|
      sum += cost
    end

    tax_amount = tax_rate * sum
    total = sum + tax_amount

    return  total.round(2)

  end

  def add_product(product_name, price)
    if @products.has_key?(product_name)
      raise ArgumentError, 'The product is already added to the order'
    end

    # Adding a pair of product and price to the product hash
    @products[product_name] = price

    return @products

  end

  # This class method returns an array(collection) of Order instances
  def self.all
    # array_of_Order_instances
    collection_of_order_instances = []
    array_orders = CSV.read('data/orders.csv').map(&:to_a)
    array_orders.each do |order|
      int_id = order[0].to_i
      hash_products = {}
      order[1].split(';').each do |p|
        product = p.split(':')
        # str_product_name, float_product_price
        hash_products[product[0]] = product[1].to_f
      end
      # Initialize an instance of Customer, int_id but passed in value is a str
      customer = Customer.find(order[2].to_i)
      sym_status = order[3].to_sym # str to sym
      instance_of_order = Order.new(int_id, hash_products, customer, sym_status)
      collection_of_order_instances << instance_of_order
    end

    return collection_of_order_instances

  end

  # this class method returns an instance order
  def self.find(id)
    array_orders = Order.all # this is how you call a class method
    array_orders.each do |order|
      # Access int_id value by calling instance getter method attr_reader :int_id
      if order.id == id
        return order
      end
    end
    return nil
  end


end
