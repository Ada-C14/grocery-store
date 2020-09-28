require_relative 'customer'
require "csv"
class Order
  attr_reader :id, :products, :customer, :fulfillment_status
  #1,Lobster:17.18;Annatto seed:58.38;Camomile:83.21,25,complete
  # def product_hash
  #   product_string_array = []
  #   CSV.read("data/orders.csv").map do |row|
  #     product_string = row[1].to_s.split(";")
  #     product_string_array << product_string
  #   end
  #   return product_string_array

    # product_string_array.map do |string|
    #   string.each do |i|
    #     temp_string = i.split(":")
    #     temp_array = []
    #     temp_array << temp_string
    #     temp_hash = temp_array.to_h
    #     print temp_hash
    #
    #   end

  def self.all
    all_orders = []
    product_string_array = []
    # CSV.read("data/orders.csv").map do |row|
    #   product_string = row[1].to_s.split(";")
    #   product_string_array << product_string
    #   temp_array = product_string_array.split(:)
    #   temp_hash = temp_array.
    # end
    CSV.read("data/orders.csv").map do |row|
      id = row[0].to_i
      products = row[1]
      customer = Customer.find(row[2].to_i)
      fulfillment_status = row[3].to_s
      new_order = Order.new(id, products, customer, fulfillment_status)
      all_orders << new_order

    end
      return all_orders

  end

  def self.find(id)
    orders = Order.all

    orders.each do |o|
      if o.id == id
        return o
      elsif o.id != id
        return nil
      end
    end
  end




  def initialize(id, products, customer, fulfillment_status=:pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    valid_status = %i[pending paid processing shipped complete]
    if !valid_status.include?(@fulfillment_status)
      raise ArgumentError
    end
  end


  def total
    no_tax = @products.values.sum.to_f
    total = no_tax + (no_tax * 0.075)
    return total.round(2)
  end

  def add_product(product_name, price)
    if @products.include?(product_name)
      raise ArgumentError.new("Product already purchased")
    end
    @products.store(product_name, price)


  end

end

