require "CSV"

CUSTOMERS = CSV.read("data/customers.csv").map { |row| row.to_a }

class Customer

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  attr_reader :id

  attr_accessor :email, :address

  def self.all
    all_customers = []
    CUSTOMERS.each do |customer|
      new_id = customer[0].to_i
      new_email = customer[1]
      new_address = {
          street: customer[2],
          city: customer[3],
          state: customer[4],
          zip: customer[5]
      }
      all_customers << Customer.new(new_id, new_email, new_address)
    end
    return all_customers
  end

  def self.find(id)
    return self.all.find { |customer| customer.id == id }
  end

end