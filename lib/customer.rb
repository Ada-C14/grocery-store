require 'csv'

class Customer
  attr_reader :id, :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    # creates a new Customer instance for each customer in the CSV file
    return CSV.read('data/customers.csv', headers: true).map do |row|
      customer = row.to_h

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


