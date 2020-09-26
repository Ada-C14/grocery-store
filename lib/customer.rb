require 'csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    keys = [:id, :email, :street, :city, :state, :zip]

    return CSV.read('data/customers.csv').map do |customer_array|
      customer = keys.zip(customer_array).to_h

      Customer.new(
          customer[:id].to_i,
          customer[:email],
          {
              street: customer[:street],
              city: customer[:city],
              state: customer[:state],
              zip: customer[:zip]
          }
      )
    end
  end

  def self.find(id)
    all_customers = Customer.all

    return all_customers.find { |customer| customer.id == id }
  end

  def self.save(filename, new_customer)
    CSV.open("data/#{filename}", "a") do |file|
      file << [
          new_customer.id,
          new_customer.email,
          new_customer.address[:street],
          new_customer.address[:city],
          new_customer.address[:state],
          new_customer.address[:zip]
      ]
    end
  end
end
