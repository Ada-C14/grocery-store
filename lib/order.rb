require 'csv'

class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  SALES_TAX_RATE = 0.075

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    raise ArgumentError if ![:pending, :paid, :processing, :shipped, :complete].include?(@fulfillment_status)
  end

  def total
    if @products.empty?
      return 0
    else
      subtotal = @products.values.inject(:+)
      tax = SALES_TAX_RATE * subtotal
      total = (subtotal + tax).round(2)
      return total
    end
  end

  def add_product(product_name, price)
    if products.key?(product_name)
      raise ArgumentError
    else
      products[product_name] = price
    end
  end

  def remove_product(product_name)
    if !products.key?(product_name)
      raise ArgumentError
    else
      products.delete(product_name)
    end
  end

  def self.all
    orders_raw = parse_order_csv('data/orders.csv')
    orders = format_orders(orders_raw)
    order_instances = make_customers(orders)

    return order_instances
  end

  def self.find(id)
    raise NotImplementedError
  end

  def self.parse_order_csv(filename)
    orders_array = CSV.read(filename).map { |row| row.to_a }
    return orders_array
  end

  def self.format_orders(orders)
    fixed_orders = []
    orders.each do |order|
      fixed_orders << [
          order[0].to_i,
          Hash[* order[1].split(/:|;/)].transform_values!(&:to_f),
          Customer.find(order[2].to_i),
          order[3].to_sym
      ]
    end
    return fixed_orders
  end

  def self.make_customers(orders)
    customers = orders.map do |order|
      Order.new(order[0], order[1], order[2], order[3])
    end
    return customers
  end

end