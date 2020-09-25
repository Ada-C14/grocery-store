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
    customer_array = []
    CSV.read('data/customers.csv').map { |row| row.to_a }.each do |customer|
      customer_array << Customer.new(customer[0].to_i, customer[1],{street:customer[2], city:customer[3], state:customer[4], zip:customer[5]})
    end
    return customer_array
  end

  def self.find(id)
    return self.all.find{|customer| customer.id == id}
  end




end