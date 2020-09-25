require 'csv'

class Customer
  attr_reader :id, :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customers = CSV.read('data/customers.csv', headers: true).map do |row|
      row.to_h
    end
    # creates customer instances using the csv data
    # returns all of the customers in an array
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

  # compares the id with all of the customers
  # if there is a match, it returns the single customer
  # no match would return nil
  def self.find(id)
    return self.all.find { |customer| customer.id == id }
  end

end


