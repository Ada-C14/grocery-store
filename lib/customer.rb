require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id # number
    @email = email # string
    @address = address #hash
  end

  # Returns a collection of Customer instances,
  # representing all of the Customer described in the CSV file
  def self.all
    all_customers = CSV.read('data/customers.csv').map do |customer_row|
      # Example row in CSV => 1,leonard.rogahn@hagenes.org,71596 Eden Route,Connellymouth,LA,98872-9105
      id = customer_row[0].to_i
      email = customer_row[1]
      address = {}
      address[:street] = customer_row[2]
      address[:city] = customer_row[3]
      address[:state] = customer_row[4]
      address[:zip] = customer_row[5]

      Customer.new(id, email, address)
    end

    return all_customers
  end

  #returns an instance of Customer
  # where the value of the id field in the CSV matches the passed parameter
  def self.find(id)
    all_customers = self.all
    found_customer = all_customers.find { |customer| customer.id == id }

    return found_customer
  end
end

