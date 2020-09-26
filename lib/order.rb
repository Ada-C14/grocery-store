require 'CSV'

class Order
  attr_reader :id, :products, :customer, :fulfillment_status, :expected_total

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    @expected_total = 0

    status_options = [:pending, :paid, :processing, :shipped, :complete]
    if !(status_options.include?(fulfillment_status))
      raise ArgumentError.new("Invalid status")
    end
  end

  def total
    total = 0
    @products.each_value do |cost|
      total += cost
    end

    calculate_tax = total * 0.075
    @expected_total = total + calculate_tax
    return @expected_total.round(2)
  end

  def add_product(product_name, price)
    before_count = @products.count

    new_product = {product_name => price}
    if @products.include?(product_name)
      raise ArgumentError.new("That product already exists") #Do i need to add in an optional gets.chomp?
    end

    @products.merge!(new_product) #why does this work?
    expected_count = before_count + 1
    return expected_count
  end

  def self.all
    orders = CSV.read('data/orders.csv').map do |order|
      id = order[0].to_i
      products = Order.product_hash(order[1]) #Order.product_hash because it's refering to my helper
      customer = Customer.find(order[2].to_i)
      fulfillment_status = order[3].to_sym

      Order.new(id, products, customer, fulfillment_status)
    end
  end

  def self.product_hash(product_string, prod_sep=';', cost_sep=':') #helper method for order.all
    products_array = product_string.split(prod_sep)
    hash = {}

    products_array.each do |item|
      key_value = item.split(cost_sep)
      hash[key_value[0]] = key_value[1].to_f
    end
    return hash
  end

  def self.find(wanted_order_id)
    order = (Order.all).find { |order| order.id == wanted_order_id}
    return order
  end
end

# emily = Customer.new('412', 'emily@gmail.com', '235928759')
#
# emily = Order.new('234', {"coffee" => 2.00}, customer, :pending)
# p emily