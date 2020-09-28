require 'csv'
# require 'awesome_print'


class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    # - `self.all` - returns a collection of `Customer` instances, representing all of the Customer described in the CSV file
    modified_csv_data = CSV.read('./data/customers.csv').map do |customer|
      Customer.new(customer[0].to_i,
                   customer[1],
                   Hash[:street, customer[2], :city, customer[3], :state,customer[4], :zip, customer[5]])
    end

    return modified_csv_data
  end

  def self.find(id)
    customer_found = Customer.all.select { |customer| customer.id == id ? customer : nil }[0]
    return customer_found
  end
end

# ap Customer.all[0].id
# ap Customer.find(2)
