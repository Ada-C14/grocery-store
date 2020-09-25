require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    all_customers = CSV.read('data/customers.csv').map { |row| row.to_a }

    all_customers = all_customers.map do |customer|
      id = customer[0].to_i
      email = customer[1]
      address = {
          street: customer[2],
          city: customer[3],
          state: customer[4],
          zip: customer[5]
      }
      Customer.new(id, email, address)
    end

    return all_customers
  end

  def self.find(id)
    self.all.select { |customer| customer.id == id }.empty? ? (return nil) : (return self.all.select { |customer| customer.id == id }[0])
  end
end