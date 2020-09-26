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

    CSV.read('data/customers.csv').map do |customer_array|
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
end
