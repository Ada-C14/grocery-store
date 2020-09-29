require 'csv'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def self.all
    return CSV.read('data/orders.csv').map do |row|
      id = row[0].to_i
      products =  product_hash(row[1])
      customer = Customer.find(row[2].to_i)
      fulfillment_status = row[3].to_sym
      Order.new(id, products, customer, fulfillment_status)
    end
  end

  def self.product_hash(product_string)
    product_hash = {}
    products = product_string.split(';')

    products.each do |product|
        name_price = product.split(':')  # ["product name", "price"]
        name_var = name_price[0]
        price_var = name_price[1].to_f
      product_hash[name_var] = price_var
    end
    return product_hash
   # 88.5 Iceberg lettuce1; Rice paper: 66.35;Amaranth:1.5 ;Walnut:65.26
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

