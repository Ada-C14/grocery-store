require 'csv'
class Customer

  attr_reader :id
  attr_accessor :email, :address
  def initialize(id, email_address, delivery_address)
    @id = id
    @email = email_address
    @address = delivery_address
  end

  def self.all
    customers = CSV.read('data/customers.csv').map { |row| row.to_a }
    customer_arr =[]
    customers.each do |customer|
      id = customer[0].to_i
      email = customer[1]
      address = {
          street: customer[2],
          city: customer[3],
          state: customer[4],
          zip: customer[5]
        }
      customer = Customer.new(id, email, address)
      customer_arr << customer
    end
    return customer_arr
    #customer.new(id, email_address, delivery_address)
    # return a collection of customer instances,
    # loop through csv, save each row as array.
  end
  # This class method is looping through an array of class instances
  # to access the id, address, email in each instance is with .id
  def self.find(id)
    Customer.all.find {|customer| customer.id == id}
  end

end
