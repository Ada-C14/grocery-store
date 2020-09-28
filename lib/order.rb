require 'csv'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def self.all
    all_orders = CSV.read('data/orders.csv').map do |row|
      id = row[0].to_i
      products =  {"item_1" => row[1].to_i, "item_2" => row[2].to_i, "item_3" => row[3].to_i}
      customer_id = row[4].to_i
      fulfillment_status = row[5]
      # Order.new((id, products, customer_id, fulfillment_status=:pending)
    end
    return all_orders
  end
  # 21,Ricemilk:38.96;Celery Seed:53.7;SwordfishTabasco:70.52,29,complete

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

