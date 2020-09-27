require "csv"
#require "awesome_print"
#require "pry"

class Customer
  attr_reader :id, :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  #returns a collection of Customer instances, representing all of the Customer described in the CSV file
  def self.all

    customers_csv = CSV.read('data/customers.csv').map { |row| row.to_a }

    customer_instances = []

    customers_csv.each do |customer|
      id = customer[0].to_i
      email = customer[1]
      address = {
        street: customer[2],
        city: customer[3],
        state: customer[4],
        zip: customer[5]
      }

      customer_instances << Customer.new(id, email, address)
    end
    return customer_instances
  end

  #returns an instance of Customer where the value of the id field in the CSV matches the passed parameter
  def self.find(id)
    all.each { |customer| return customer if customer.id == id }
    return nil
  end
end
