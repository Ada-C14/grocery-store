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
    return CSV.read('data/customers.csv').map do |customer|
      Customer.new(
          customer[0].to_i,
          customer[1],
          {
              street: customer[2],
              city: customer[3],
              state: customer[4],
              zip: customer[5]
          }
      )
    end
  end

  def self.find(id)
    all_customers = Customer.all

    return all_customers.find { |customer| customer.id == id }
  end
end
