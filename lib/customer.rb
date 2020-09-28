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
    customer_csv = CSV.read('data/customers.csv').map { |row| row.to_a }

    customers = customer_csv.map do |array|
      Customer.new(array[0].to_i, array[1], {
          street: array[2],
          city: array[3],
          state: array[4],
          zip: array[5]
      })
    end

    return customers
  end

  def self.find(id)
    found_customer = Customer.all.find { |customer| customer.id == id }

    return found_customer
  end

  def self.save(filename, new_customer)
    CSV.open(filename, 'a') do |csv|
      customer_data = [new_customer.id, new_customer.email, new_customer.address[:street], new_customer.address[:city], new_customer.address[:state], new_customer.address[:zip]]

      csv << customer_data
    end
  end
end