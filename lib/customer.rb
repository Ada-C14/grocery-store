require "csv"

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
        zip: row[5],
      }
      new_format = Customer.new(row[0].to_i, row[1], address_format)
      customers << new_format
    end

    return customers
  end

  def self.find(id)
    found_customer = Customer.all.find { |customer| customer.id == id.to_i }
    return found_customer
  end

end
