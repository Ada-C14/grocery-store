require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, delivery_address)
    @id = id
    @email = email
    @address = delivery_address
  end
  
  def self.all
    @customer = Array.new
    CSV.read('data/customers.csv').each { |customer| @customer.push(self.new(customer[0].to_i, customer[1], Hash(street: customer[2], city: customer[3], state: customer[4], zip: customer[5]))) }
    return @customer
  end

  def self.find(id)
    return self.all.find { |customer| customer.id == id }
  end

end