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
    customer_info = []
    customers = CSV.read('data/customers.csv').map { |customer| customer.to_a }
    customers.each do |customer|
      id = customer[0].to_i
      email = customer[1]
      address = { street: customer[2], city: customer[3], state: customer[4], zip: customer[5] }
      customer_info << Customer.new(id, email, address)
    end
    return customer_info
  end

  def self.find(id)
    return all.find { |customer| customer.id == id }
  end
end

