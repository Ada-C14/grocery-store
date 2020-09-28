require "csv"

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id #number
    @email = email #string
    @address = address #hash
  end

  # # returns a collection of Customer instances, representing all of the Customer described in the CSV file
  def self.all
    customer_instances = []

    # Test if I need .to_a here because CSV.read returns an array
    customers_csv = CSV.read('data/customers.csv').map { |customer| customer.to_a }
    customers_csv.each do |customer|
      id = customer[0].to_i #already intenger
      email = customer[1].to_s #already string
      address = {
        street: customer[2],
        city: customer[3],
        state: customer[4],
        zip_code: customer[5]
      }
      customer_instances << Customer.new(id, email, address)
    end

    return customer_instances
  end


  def self.find(id)
    # returns an instance of Customer where the value of the id field in the CSV matches the passed parameter
    customers_all = self.all
    customers_all.each do |customer|
      if customer.id == id
        return customer
      end
    end
    return nil
  end

  # Customer.find should not parse the CSV file itself.
  # Instead it should invoke Customer.all and search through the results for a customer with a matching ID.

end