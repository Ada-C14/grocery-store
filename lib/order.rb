require 'csv'

# Create a class called Order (Wave 1)
class Order
  # ID should be readable but not writable
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  # Define method initialize,
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id # integer
    @products = products # empty hash
    @customer = customer

    list_of_status = [:pending, :paid, :processing, :shipped, :complete]
      if list_of_status.include? fulfillment_status
        @fulfillment_status = fulfillment_status
      else
        raise ArgumentError, "This is a invalid fulfillment status"
      end
  end

  # Find total cost of an order(Wave 1)
  def total
    total_cost = 0
    if @products.count == 0
      return  0
    end
    @products.each do |name, cost|
      total_cost += cost
    end
    total_cost += (total_cost * 0.075)
    return total_cost.to_f.round(2)
  end

  # Add product to an order, if it's a duplicate, raise exception (Wave 1)
  def add_product(name, price)
    if @products.has_key?(name)
      raise ArgumentError, "Product already exists in the system!"
    else
      @products[name] = price
    end
  end

  # Removes a product from the instance of Order if it does exist
  def remove_product(product_name)
    if @products.has_key?(product_name)
      @products.delete(product_name)
    else
      raise ArgumentError, "Product already doe not exists in the system!"
    end
  end
  # (Wave 2)
  # Use a CSV file for loading data (Wave 2)
  #
  def self.product_list(products)
    products_list = {}

    products.split(";").each do |items|
      items_array = items.split( ":")
      products_list[items_array[0]] = items_array[1].to_f
    end
    return products_list
  end

  def self.all
    all_orders = CSV.read('data/orders.csv').map do |row|

      id = row[0].to_i
      products =  product_list(row[1])
      customer = Customer.find(row[2].to_i)
      fulfillment_status = row[3].to_sym

      new_customer = self.new(id, products, customer, fulfillment_status)
    end
    return all_orders
  end

  # Returns instance of Order that matches id argument (Wave 2)
  def self.find(id)
   orders = self.all
    order_find = orders.find do |order|
      order.id == id
    end
    # returns nil if not found
    return order_find
  end

  # Returns instance of Order that matches customer id argument
  def self.find_by_customer(customer_id)
    orders = self.all
    order_matches = orders.find_all do |order|
      order.customer.id == customer_id
    end
      if order_matches.length > 0
        return  order_matches
      else
        return nil
      end
  end
end