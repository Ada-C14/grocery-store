#WAVE 1 --> Create a class called Order
require 'csv'

class Order
  #ID is readable
  attr_reader :id
  attr_accessor :products, :customers,:fulfillment_status

  def initialize
    @id = id
    @products = products
    @customers = customers
  end

  fullfillment_status = [:pending, :paid, :processing, :shipped, :complete]



  # Method that will find total cost of an order(Wave 1)


end