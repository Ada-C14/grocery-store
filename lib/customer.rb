require 'csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  # returns a collection of Customer instances
  def self.all
    customer_instances = []
    customers = CSV.read('data/customers.csv').map { |row| row.to_a }
    customers.each do |customer|
      id = customer[0].to_i
      email = customer[1]
      address_hash = {
        street: customer[2],
        city: customer[3],
        state: customer[4],
        zip: customer[5]
      }
      customer_instances << Customer.new(id, email, address_hash)
    end
      return customer_instances
  end

  # return instance of customer (the object) or nil
  def self.find(id)
    Customer.all.find {|customer| customer.id == id}
  end

  # optional
  def self.save(filename, new_customer)
    id = new_customer.id
    email = new_customer.email
    address = new_customer.address.values
    customer_array = [id, email, address].flatten
    CSV.open(filename, 'a') do |csv|
      csv << customer_array
    end
  end
end

