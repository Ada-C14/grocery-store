require "csv"

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id_number, email_address, delivery_address)
    @id = id_number
    @email = email_address
    @address = delivery_address
  end

  def self.all

    customer_list = []

    # for rake
    # cust = CSV.read("data/customers.csv")

    cust = CSV.read("../data/customers.csv")

    cust.each do |customer|
      id_number = customer[0].to_i
      email_address = customer[1]
      delivery_address = {
          street: customer[2],
          city: customer[3],
          state: customer[4],
          zip: customer[5]
      }
      customer_list.push(Customer.new(id_number, email_address, delivery_address))
    end
    return customer_list
  end

  def self.find(id_number)
    customer_list = Customer.all
    return customer_list.find{|customer| customer.id == id_number}
  end

  def self.save(filename, new_customer)
    CSV.open(filename, "w") do |file|
      file << [new_customer.id, new_customer.email, new_customer.address[:street], new_customer.address[:city], new_customer.address[:state], new_customer.address[:zip]]
    end
    return true
  end
end