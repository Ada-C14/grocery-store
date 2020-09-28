require 'csv'
require 'awesome_print'


class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    modified_csv_data = CSV.read('./data/customers.csv').map do |customer|
      Customer.new(customer[0].to_i,
                   customer[1],
                   Hash[:street, customer[2], :city, customer[3], :state,customer[4], :zip, customer[5]])
    end

    return modified_csv_data
  end

  def self.find(id)
    # - `self.find(id)` - returns an instance of `Customer` where the value of the id field in the CSV matches the passed parameter
    #  `Customer.find` should not parse the CSV file itself.
    # Instead it should invoke `Customer.all` and search through the results for a customer with a matching ID.
  end
end

ap Customer.all