require 'csv'

# Create a class called Customer (Wave 1)
class Customer

  # ID should be readable but not writable
  attr_reader :id
  # Email and delivery_address can be both read and written
  attr_accessor :email, :address

  # Define method initialize
  def initialize(id, email, address)
    @id = id # integer
    @email = email
    @address = address
  end

  # Use a CSV file for loading data (Wave 2)
  def self.all
    all_customers = CSV.open('data/customers.csv').map do |row|

    id = row[0].to_i
    email =  row[1]

    address = {
        street: row[2],
        city: row[3],
        state: row[4],
        zip: row[5]
    }
    new_customer = self.new(id, email, address)
    end
    return all_customers
  end

  # Returns instance of Customer that matches id argument (Wave 2)
  def self.find(id)
    customers = self.all
    customer_find = customers.find do |customer|
      customer.id == id
    end
    # returns nil if not found
    return customer_find
  end

  # Writing a new customer's information into a new customer CSV file (Wave3)
  def self.save(filename, new_customer)
    CSV.open(filename, "w") do |csv| # Mode w i use to write, to add more rows I have to use mode a
    csv << [new_customer.id, new_customer.email, new_customer.address]
    end
    return true
    end
end
