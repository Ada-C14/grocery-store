require 'csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  # I have a scope issue here below.

  def self.all

    all_customers = []

    customer_array = CSV.read('data/customers.csv')
    customer_array.each do |customer|

      address = {}

      id = customer[0].to_i
      email = customer[1]
      address[:street] = customer[2]
      address[:city] = customer[3]
      address[:state] = customer[4]
      address[:zip] = customer[5]

      all_customers << Customer.new(id, email, address)

    end
    return all_customers
  end

  p self.all.first
  p self.all.last

  def self.find(id)
    customer = self.all.find { |customer| customer.id == id }
    return customer
  end

end
