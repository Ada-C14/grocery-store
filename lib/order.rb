require_relative "customer"

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending) # keyword argument/optional argument. Check
    @id = id
    @products = products # { "banana" => 1.99, "cracker" => 3.00 }
    @customer = customer
    @fulfillment_status = fulfillment_status
    if ![:pending, :paid, :processing, :shipped, :complete].include?(@fulfillment_status)
      raise ArgumentError, "Invalid fulfillment status"
    end
  end

  # Create product collection, array of hashes
  # Check if order_products is empty hash
  def total
    subtotal = @products.values.sum
    subtotal_tax = subtotal * 1.075
    total = sprintf('%.2f', subtotal_tax).to_f

    return total
  end



  # Problem of accessing product_collection array from outside method
  def add_product(product_name, price)
    # .key? or has_key?
    if @products.key?(product_name)
      raise ArgumentError, "Product name already exists"
    else
      @products[product_name] = price
    end

    return product_name
  end

  def self.all
    # returns a collection of Order instances, representing all of the Orders described in the CSV file
  end

  def self.find(id)
    # returns an instance of Order where the value of the id field in the CSV matches the passed parameter
    # Order.find should call Order.all instead of loading the CSV file itself.
  end

end