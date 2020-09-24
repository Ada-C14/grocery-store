require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  # self.all and self.find are class methods
  # return a collection of Customer instances, representing all of the Customers describe in the CSV file
  # dp we need params for the all class method?
  def self.all
    # need to read in the csv
    # how do I transfer CSV data into an array?
    customer_array = []
    customer_data = CSV.read('data/customers.csv').map { |customer| customer.to_a }
    customer_data.each do |customer|
      id = customer[0].to_i
      email = customer[1]
      #delivery_address is a hash
      address = {street: customer[2], city: customer[3], state: customer[4] , zip: customer[5]  }
      customer_array << Customer.new(id, email, address)
    end
    return customer_array # => array of all the customer instances
  end

  def self.find(id)
    # should invoke Customer.all and search through the results for a customer with a matching ID
    return all.find {|customer| customer.id == id} # returns nil if ID is not found
    
  end

end