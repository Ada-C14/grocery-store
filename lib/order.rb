require 'csv'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    valid_fulfillment_status = [:pending, :paid, :processing, :shipped, :complete]

    @id = id
    @products = products #hash { "banana" => 1.99, "cracker" => 3.00 }
    @customer = customer #instance of customer
    @fulfillment_status = fulfillment_status
    raise ArgumentError, "#{fulfillment_status} is not a valid status." if !valid_fulfillment_status.include?(fulfillment_status)
  end

  # Calculates the total cost of the order
  def total
    individual_costs = @products.values
    total_cost = individual_costs.sum
    taxed_total_cost = total_cost + total_cost * 0.075

    return taxed_total_cost.round(2)
  end

  # Method which will take in two parameters, product name and price,
  # and adds the data to the product collection
  def add_product(product_name, price)
    raise ArgumentError, "#{product_name} already exists in the order." if @products.include?(product_name)

    @products[product_name] = price
  end

  # Method which will take in one parameters, product name,
  # and removes the data to the product collection
  def remove_product(product_name)
    raise ArgumentError, "#{product_name} not found in order." unless @products.include?(product_name)

    @products.delete(product_name)
  end

  # Parse product list in format name:price;nextname:nextprice
  # and return hash { product => cost }
  def self.parse_product_list(product_list)
    separated_products = product_list.split(";") # => ["Lobster:17.18", "Annatto seed:58.38"]
    products_hash = {}
    separated_products.each do |product_and_cost|
      product_cost_split = product_and_cost.split(':')
      product = product_cost_split[0]
      cost = product_cost_split[1].to_f
      products_hash[product] = cost
    end

    return products_hash
  end

  # Returns a collection of Order instances,
  # representing all of the Orders described in the CSV file
  def self.all
    all_orders = CSV.read('data/orders.csv').map do |order_row|
      # Example row in CSV => 1,Lobster:17.18;Annatto seed:58.38;Camomile:83.21,25,complete
      id = order_row[0].to_i

      products_string = order_row[1] # => "Lobster:17.18;Annatto seed:58.38;Camomile:83.21,25,complete"
      products = parse_product_list(products_string)

      customer_id = order_row[2].to_i
      customer = Customer.find(customer_id)

      fulfillment_status = order_row[3].to_sym

      Order.new(id, products, customer, fulfillment_status)
    end

    return all_orders
  end

  # Returns an instance of Order
  # where the value of the id field in the CSV matches the passed parameter
  def self.find(id)
    all_orders = self.all
    found_order = all_orders.find { |order| order.id == id }

    return found_order
  end
end