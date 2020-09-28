require 'csv' #ruby reads the csv file
require_relative 'customer' #knows about customer class

#assume there is only one of each product
class Order

  attr_reader :id
  attr_accessor :products,  :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id #number
    @products = products #{"melon" => 9.99, "chips" => 3.00} ] cost from cvs?
    @customer = customer #from customer class
    @fulfillment_status = fulfillment_status

    raise ArgumentError.new("Invalid fulfillment status.") if [:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status) != true
  end

  def total
    if @products.empty?
      return 0
    else
      total = @products.values.sum
      total = (total*1.075).round(2)
    end
    return total
  end

  def add_product(product_name, product_price)
    raise ArgumentError.new("This product already exists.") if  @products.include?(product_name)

    @products[product_name] = product_price
    # data = {product_name => product_price}  foam[:500]
    # @products << data

  end

  # def remove_product(product_name)
  # raise ArgumentError.new("Product not found.") if product_name == nil
  #if @products.key?(name)
  # # return @products.delete(name)
  # end
  # write a test for it it is similar to the add_product test
  # "mellow yellow".split("ello")   #=> ["m", "w y", "w"]
  def self.all
    #returns a collection of Order instances representing all of the Orders
    # described in the CSV file
    #all = []
    # id, products, customer, fulfillment_status
    orders = CSV.read('data/orders.csv').map do |order_data| #{|x| x + "!"} array.map { |string| string.upcase }

    id = order_data[0].to_i
    products = product_hash[order_data[1]] #invoke helper method to parse mirror what csv shows contains product and price
    customer = Customer.find(order_data[2].to_i)
    fulfillment_status = order_data[3].to_sym #for notation purposes?
    Order.new(id, products, customer, fulfillment_status )
    end
    #p orders
    #return orders
  end

  def product_hash(product_string, item_sep=";", cost_sep=":")
    products_array = product_string.split(item_sep) # this does not return 1 product it turns it into an array split by ;
    # return product and cost items as an array and split by semicolon
    hash = {}
    products_array.each do |i|
      #look for the semicolon and split into an array at semicolon
      # it is looking for whateevr symbol you want it to split at all
      product_cost_array = i.split(cost_sep) #returns an array of product and cost seperated by semicolon
      hash[product_cost_array[0]] = product_cost_array[1].to_f
    end
    return hash
  end

  def self.find(id)
     Order.all.find do |order| order.id == id
    end
  end

end

