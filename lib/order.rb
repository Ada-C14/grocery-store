require_relative 'customer'
class Order
  attr_reader :id
  attr_accessor :customer, :products, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    valid_symbols = [:pending, :paid, :processing, :shipped, :complete]
    if !(valid_symbols.include?(fulfillment_status))
      raise ArgumentError, "Invalid fulfillment status"
    end
    @fulfillment_status = fulfillment_status
  end

  def total
    sum = 0
    @products.each do |product, cost|
      sum += cost
    end
    tax = sum *  0.075
    total_cost = sum + tax
    return total_cost.round(2)
  end

  def add_product(name, price)
    @products.each do |product, cost|
      if name == product
        raise ArgumentError.new("This product is already in our collection.")
      end
    end
    @products[name] = price
  end
  def self.all
    #customers = []
    #customer_data = nil
    # id, products, customer, fulfillment_status = :pending
    orders = []
    CSV.foreach('data/orders.csv') do |row|
      products_array = row[1].split(';')
      products = {}
      products_array.each do |product|
        prod_cost = product.split(':')
        name = prod_cost[0]
        cost = prod_cost[1].to_f
        products[name] = cost
      end
      customer = Customer.find(row[2].to_i)
      order_data = Order.new(row[0].to_i, products, customer, row[3]&.to_sym)
      orders << order_data

    end
    orders
  end

  def self.find(id)
    Order.all.each do |x|
      if id == x.id
        return x
      end
    end
    return nil
  end
end

