require "CSV"

class Customer

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  attr_reader :id

  attr_accessor :email, :address

  def self.all
    all_customers = CSV.read("data/customers.csv").map { |customer|
      Customer.new(customer[0].to_i, customer[1], {
            street: customer[2],
            city: customer[3],
            state: customer[4],
            zip: customer[5]
        }
      )
    }
    return all_customers
  end

  def self.find(id)
    return self.all.find { |customer| customer.id == id }
  end

  def self.save(filename, new_customer)
    customer_array = %W[#{new_customer.id} #{new_customer.email} #{new_customer.address[:street]} #{new_customer.address[:city]} #{new_customer.address[:state]} #{new_customer.address[:zip]}]
    CSV.open(filename, "a") do |file|
      file << customer_array
    end
    return true
  end

end