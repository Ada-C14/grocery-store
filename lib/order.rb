require 'csv'

class Order
  attr_reader(:id, :fulfillment_status)
  attr_accessor(:products, :customer)

  VALID_STATUS = %i[pending paid processing shipped complete].freeze # add tips symbol step 1

  def initialize(id, products, customer, fulfillment_status = :pending) # add tips
    @id = id
    @products = products
    @customer = customer
    self.fulfillment_status = fulfillment_status
  end

  def fulfillment_status=(fulfillment_status) # the writer method step 3
    validate_fulfillment_status(fulfillment_status)
    @fulfillment_status = fulfillment_status
  end

  def validate_fulfillment_status(fulfillment_status)
    unless VALID_STATUS.include? fulfillment_status
      raise ArgumentError, "Invalid status #{fulfillment_status}" # add to tips step 2
    end
  end

  def total
    tax = 7.5/100.0
    total = @products.values.sum
    total_with_tax = total + (total * tax)
    return total_with_tax.round(2)
  end

  def add_product(product_name, price)
    if @products.include? product_name
      raise ArgumentError, "#{product_name} is already in products list"
    else

      @products[product_name] = price
    end
  end

  def self.product_hash(products)
    products = products.split(";")
    array = []

    products.each do |product|
      array << product.split(":")
    end

    hash = array.to_h

    hash.each do |key,value|
      hash[key] = value.to_f
    end

    hash
  end

  def self.all
    orders_data = CSV.read('data/orders.csv', headers:true).map { |row| row.to_h }
    orders = orders_data.map do |order|
      Order.new(order['id'].to_i, self.product_hash(order['products']), order['customer_id'].to_i, order['fulfillment_status'].to_sym)
    end
    orders
  end

  def self.find(id)
    orders = self.all
    orders.each do |order|
      if order.id == id
        return order
      end
    end
    return nil
  end

end