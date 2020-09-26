require 'csv'

class Customer
  attr_accessor :email, :address
  attr_reader :id

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    all = []

    csv = CSV.read('data/customers.csv')
    csv.each do |data|
      id = data[0].to_i
      email = data[1]
      address = {
          street: data[2],
          city: data[3],
          state: data[4],
          zip: data[5]
      }
      all << Customer.new(id, email, address)
    end

    return all
  end

  def self.find(id)
    Customer.all.find { |customer| customer.id == id }
  end

  def self.save (filename, new_customer)
    info =[]
    info[0] = new_customer.id,
        info[1] = new_customer.email,
        info[2] = new_customer.address[:street],
        info[3] = new_customer.address[:city],
        info[4] = new_customer.address[:state],
        info[5] = new_customer.address[:zip]
    customer_data = [info]

    csv = CSV.open(filename, "a+") do |file|
      customer_data.each do |info|
        file << info
      end
    end
  end
end

