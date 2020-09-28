require 'csv'

class Customer
  attr_reader :id, :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    # reads the customers.csv and formats each row into a hash
    customers = CSV.read('data/customers.csv', headers: true).map do |row|
      row.to_h
    end
    # creates a new Customer instance for each customer in the CSV file
    return customers.map do |customer|
      address = {
          street: customer["street"],
          city: customer["city"],
          state: customer["state"],
          zip: customer["zip"]
      }

      Customer.new(customer["id"].to_i, customer["email"], address)
    end
  end

  # iterates through all of the customers to find the matching ID
  # no match would return nil
  def self.find(id)
    return self.all.find { |customer| customer.id == id }
  end

end


