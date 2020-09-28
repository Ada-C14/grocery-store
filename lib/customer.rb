require 'csv'
#require_relative 'order'

#see Quick note for CSV to array transformation

class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id #number
    @email = email #string
    @address = address #hash
  end

  def self.all
    #returns a collection of Customer instances representing all of the Customer
    # described in the CSV file
    #all = []
    customers = CSV.read('data/customers.csv').map do |customer_data| #{|x| x + "!"} array.map { |string| string.upcase }
    id = customer_data[0].to_i
    email = customer_data[1]
    address = {
        street: customer_data[2],
        city: customer_data[3],
        state: customer_data[4],
        zip: customer_data[5]
    } #p address
    Customer.new(id, email, address)
    end
    #p customers
    return customers
  end

  def self.find(id)
    find_customer = Customer.all.find do |customer| customer.id == id
    end
    #raise ArgumentError.new("No matching ID found") if find_customer == nil
  end

end