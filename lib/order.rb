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

  # 86,Jasmine rice:73.43;Soy Milk:1.69,4,pending
  # returns a collection of Order instances, representing all of the Orders described in the CSV file
  def self.all
    order_instances = []

    orders_csv = CSV.read('data/orders.csv').map { |order| order.to_a}
    orders_csv.each do |row|
      id = row[0].to_i
      products_hash = {}
      products_array = row[1].split(/;/)
      products_array.each do |product|
        item = product.split(/:/)
        item_key = item[0]
        item_value = item[1]
        products_hash[item_key] = item_value.to_f
      end
      customer_id = Customer.find(row[2].to_i)
      fulfillment_status = row[3].to_sym

      order_instances << Order.new(id, products_hash, customer_id, fulfillment_status)
    end

    return order_instances
  end


  # returns an instance of Order where the value of the id field in the CSV matches the passed parameter
  # Order.find should call Order.all instead of loading the CSV file itself.
  def self.find(id)
    orders_all = self.all
    orders_all.each do |order|
      if order.id == id
        return order
      end
    end

    return nil
  end

end