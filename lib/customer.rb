require 'pry'
require 'csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  # wave 2
  # method to returns a collection of Customer instances
  def self.all

    collection_of_customer = []

    customers_arr= CSV.read('data/customers.csv')
    customers_arr.each do |customer|

      address = {}
      id = customer[0].to_i
      email = customer[1]
      address[:street] = customer[2]
      address[:city] = customer[3]
      address[:state] = customer[4]
      address[:zip] =  customer[5]
      customer_instance = Customer.new(id, email, address)
      collection_of_customer << customer_instance
    end
    return collection_of_customer
  end

  # method that get the id and returns an instance of Customer
  def self.find(id)
    customer = all.find { |customer| customer.id == id}
    return customer
  end

end


