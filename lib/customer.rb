require 'csv'

class Customer
  # Helper methods
  attr_reader :id
  attr_accessor :email, :address

  # Constructor
  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end
  # Class method returns a collection of Customer instances
  def self.all
    new_customer_list = []
    customers = CSV.read('data/customers.csv').map(&:to_a) # {|row| row.to_a}
    customers.each do |customer|
      address = {
        street: customer[2],
        city: customer[3],
        state: customer[4],
        zip: customer[5]
      }
      # Initialize an instance of Customer
      new_customer = Customer.new(customer[0].to_i, customer[1], address)
      new_customer_list << new_customer
    end
    # Collection of Customer instances
    return new_customer_list
  end
  # Class method
  def self.find(id)
    customers = Customer.all # this is how you call a class method
    customers.each do |customer|
      # Access id value by calling instance getter method attr_reader :id
      if customer.id == id
        return customer
      end
    end
    return nil
  end

  
end
