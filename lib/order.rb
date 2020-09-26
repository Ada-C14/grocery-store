require 'csv'
require 'customer'

class Order
  VALID_STATUSES = [:pending, :paid, :processing, :shipped, :complete]
  #adding a constant with the list of default fulfilment_status values
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status=:pending) #setting default value of status
    validate_status(fulfillment_status) #calling validate_status method to check if a passed value is valid
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    array_costs = @products.values
    return (array_costs.sum * 1.075).round(2)
  end

  #{ "banana" => 1.99, "cracker" => 3.00 }
  def add_product(product_name, price)
    @products.each_key do |key|
      if product_name == key
        raise ArgumentError.new
      end
    end

    @products[product_name] = price

  end

  def remove_product(product_name)
      @products.each_key do |key|
        if product_name == key
          @products.delete(product_name)
        else
            raise ArgumentError.new
        end
      end
  end


  #validation status method check if parameter's value is included in the list of default values.
  # if it is then proceeding with initializing of a class instance, if nor raise an argument error
  def validate_status(fulfillment_status)
    if !VALID_STATUSES.include?(fulfillment_status)
      raise ArgumentError.new("Wrong fulfillment_status #{fulfillment_status}")
    end
  end

  #1,Lobster:17.18;Annatto seed:58.38;Camomile:83.21,25,complete
  def self.all
    all_orders = []
    CSV.read('data/orders.csv').each do |order_row|
      id = order_row[0].to_i
      products = {}
      products_array = order_row[1].split(';')
      products_array.each do |item|
        product_and_price = item.split(':')
        products[product_and_price[0]] = product_and_price[1].to_f
      end

      customer_id = order_row[2].to_i
      customer = Customer.find(customer_id)
      fulfillment_status = order_row[3].to_sym

      all_orders << Order.new(id, products, customer, fulfillment_status)
    end

    return all_orders
  end


  def self.find(id)
    all_orders = self.all
    all_orders.each do |order|
      if order.id == id
        return order
      end
    end
    return nil
  end
end

