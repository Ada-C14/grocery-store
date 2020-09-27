require_relative "customer"
require "csv"

class Order
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    @fulfillment_status = fulfillment_status
    @options = [:pending, :paid, :processing, :shipped, :complete]
    if @options.include?(@fulfillment_status) == false
      raise ArgumentError
    end

  end

  def total
    @total_cost = 0.00
    if @products == nil
      return @total_cost = 0.0
    else
      @products.each_value { |value| @total_cost += value }
      @total_cost += (0.075 * @total_cost).round(2)
    end
  end

  def add_product(product_name, price)
    @product_name = product_name
    @price = price
    if @products.key?(@product_name)
      raise ArgumentError
    else
      @products.store(@product_name, @price)
    end
  end

  def self.all
    # everything from the csv file is going in here as strings as of right now; each row is a an array
    # an array of arrays (rows) of strings(each column)- separated by commas
    @arr_of_instances = CSV.read('C:\Users\alice\ADA\grocery-store\data\orders.csv').map do |row|
      # ================>>>>>>> 1,Lobster:17.18;Annatto seed:58.38;Camomile:83.21,25,complete
      hash_products_perorder = {}
      array1 = row[1].split(';')
      # array1 = [Lobster:17.18, Annatto seed:58.38, Camomile:83.21]

      array1.each do |element|
        keyandvalue = element.split(':')
        # keyvalue = [Lobster, 17.18]
        k = keyandvalue[0]
        # k = Lobster
        v = keyandvalue[1]
        # v = 17.18
        hash_products_perorder[k] = v.to_f
      end

      customer = Customer.find(row[2].to_i)

      Order.new(row[0].to_i, hash_products_perorder, customer, row[3].to_sym)
    end
    return @arr_of_instances
  end

  def self.find(id)
    values = Order.all
    values.each do |instance|
      if instance.id == id
        return instance
      end
    end
    return nil
  end
end

# thisthing = Order.all
# puts thisthing[0].products
# puts thisthing[99].customer.email

