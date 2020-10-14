require 'csv'
require 'awesome_print'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customer_data = CSV.read("data/customers.csv")

    customers = []

    customer_data.each do |row|
      address_format = {
        street: row[2],
        city: row[3],
        state: row[4],
        zip: row[5]
      }
      new_format = Customer.new(row[0].to_i, row[1], address_format) 
      customers << new_format
    end 
      return customers
  end

 #returns an instance of Customer where the value of the id field in the CSV matches the passed paramete

def self.find(id)
  selected_id = self.all.find { |customer| customer.id == id }
  return selected_id
end 

  # ap self.all


end
