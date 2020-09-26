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
    all_customer_instances = []

    CSV.read('data/customers.csv').map { |customer| customer.to_a }.each do |customer|
      id = customer[0].to_i
      email = customer[1]
      address = {
          street: customer[2],
          city: customer[3],
          state: customer[4],
          zip: customer[5]
      }
      all_customer_instances << Customer.new(id, email, address)
    end
    return all_customer_instances
  end

  def self.find(id)

    found_customer = Customer.all.find { |customer| customer.id == id }  #NOTE TO SELF customer.id

    #raise ArgumentError.new("Id not found") if found_customer.nil?

    return found_customer
  end


end

#p Customer.all