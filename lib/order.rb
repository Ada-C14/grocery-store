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

  def self.all
    # returns order instances, representing all the orders represented in the CSV file
    orders_csv = CSV.read('data/orders.csv').map { |row| row.to_a }

    order_instances = []

    orders_csv.each do |order|

      order_id = order[0].to_i

      order_hsh = {}
      product_items_arr = order[1].split(';')
      product_items_arr.each do |item|
        product = item.split(':')
        product_key = product[0]
        product_value = product[1]
        order_hsh[product_key.to_s] = product_value.to_f
      end

      customer_id = Customer.find(order[2].to_i)
      status = order[3].to_sym

      order_instances << Order.new(order_id, order_hsh, customer_id, status)

    end
    return order_instances
  end
end