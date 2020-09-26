require 'csv'

class Customer
  attr_accessor :email, :address
  attr_reader :id

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    all = []

    csv = CSV.read('data/customers.csv')
    csv.each do |data|
      id = data[0].to_i
      email = data[1]
      address = {
          street: data[2],
          city: data[3],
          state: data[4],
          zip: data[5]
      }
      all << Customer.new(id, email, address)
    end

    return all
  end

  def self.find(id)
    Customer.all.find { |customer| customer.id == id }
  end

  def save ("new_customer.csv", new_customer)
    customer_data = [
        new_customer[0] = customer.id,
        new_customer[1] = customer.email,
        new_customer[2] = customer.address[street],
        new_customer[3] = customer.address[city],
        new_customer[4] = customer.address[state],
        new_customer[5] = customer.address[zip]
    ]
    csv = CSV.open("new_customer.csv", "a+") do |file|
      customer_data.each do |info|
        file << info
      end
    end
  end
end

#Customer.new receives Id, a number; email address, a string; and delivery address, a hash (with three elements)
# The Customer CSV file has 6 columns: integer, 5 sets of strings
# Customer ID	Integer	A unique identifier corresponding to the Customer
# Email	String	The customer's e-mail address
# Address 1	String	The customer's street address
# City	String	The customer's city
# State	String	The customer's state
# Zip Code	String	The customer's zip code