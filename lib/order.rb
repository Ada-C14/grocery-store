require 'csv'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def self.all
    all_orders = CSV.read('data/orders.csv').map do |row|
      id = row[0].to_i
      products =  row[1]
      customer = Customer.find(row[2].to_i)
      fulfillment_status = row[3].to_sym
      order = Order.new(id, products, customer, fulfillment_status)
    end
    return all_orders
  end


  def self.find(id)
    orders = Orders.all

    orders.each do |order|
      return order if order.id == id
    end
    return nil
  end

  def initialize(id, products, customer_id, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer_id
    @fulfillment_status = fulfillment_status
    valid_statuses = %i[pending paid processing shipped complete]

    valid_statuses.each do |status|
      unless valid_statuses.include? fulfillment_status
        raise ArgumentError, 'bogus status'
      end
    end
  end

  def total
    total_price = 0
    sales_tax = 7.5/100
    products.each_value do |price|
      total_price += price
    end
    total_with_tax = (total_price * sales_tax).round(2) + total_price
  end

  def add_product(name, price)
      raise ArgumentError if @products.key?(name)
    @products[name] = price
  end
end

