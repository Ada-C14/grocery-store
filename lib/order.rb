#WAVE 1 --> Create a class called Order
require 'csv'

class Order
  #ID is readable
  attr_reader :id
  attr_accessor :products, :customer,:fulfillment_status

  def initialize(id,products,customer,fulfillment_status = :pending)
    good_Values = [:pending,:paid,:processing,:shipped,:complete]
    if !good_Values.include(fulfillment_status)
      raise ArgumentError, "#{fulfillment_status} Order status error.  Need valid status."
    end
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end
  # Method that will find total cost of an order and add tax (Wave 1)
  def total
    if @products.empty?
      return 0
    else
      total = (@products.values.sum * 1.075).round(2)
    end
    return total
  end

  #Method that will add products to order, and check for duplicates

  def add_product(product_name,price)
    if @products.has_key?(product_name)
      raise ArgumentError, "#{product_name} has already been added"
    end
    return @products[product_name] = price
  end

  #Parse the list of products into a hash
  def self.helper_split_string_to_hash_method(product)
    products = Hash.new(0)
    product.split(/;/).each do |product_value_pair|
      product, price  = product_value_pair.split(/:/)
      products[product] = price.to_f
    end
    return products
  end





end