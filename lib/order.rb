require 'csv'
require_relative 'customer'

class Order
  # Getter method return :id, @id value when calls
  attr_reader :id, :products, :customer, :fulfillment_status

  # Constructor
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    status_validation(fulfillment_status)
    @fulfillment_status = fulfillment_status
  end

  def status_validation(fulfillment_status)
    case fulfillment_status
    when :pending, :paid, :processing, :shipped, :complete
      return fulfillment_status
    else
      raise ArgumentError, 'The status is invalid'
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

  # This class method return a collection of Order instances
  def self.all
    # Collection of Order instances
    collection_of_order_instances = []
    array_orders = CSV.read('data/orders.csv').map(&:to_a)
    array_orders.each do |order|
      id = order[0].to_i
      products = {}
      order[1].split(';').each do |p|
        product = p.split(':')
        products[product[0]] = product[1]
      end

      # Initialize an instance of Customer
      customer = Customer.find(order[2])

      status = order[3].to_sym
      # Initialize an instance of order
      instance_of_order = Order.new(id, products, customer, status)
      collection_of_order_instances << instance_of_order
      return collection_of_order_instances
    end
  end

end

# puts Dir.pwd
# order = Order.all