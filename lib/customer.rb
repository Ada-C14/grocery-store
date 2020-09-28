require "csv"
# require_relative 'customers'


class Customer


  def self.all
    all_customers = []
    CSV.read("data/customers.csv").map do |row|
      address = {}
      id = row[0].to_i
      email = row[1]
      address[:street] = row[2]
      address[:city] = row[3]
      address[:state] = row[4]
      address[:zip] = row[5]
      new_customer = Customer.new(id, email, address)
      all_customers << new_customer
    end
    return all_customers

  end

  def self.find(id)
    customers = Customer.all

    customers.each do |c|
      if c.id == id
        return c
      elsif c.id != id
        return nil
      end
    end


  end
  attr_reader :id, :address, :email
  attr_accessor :address, :email

  def initialize(id, email, address)
    @id = id
    @address = address
    @email = email
  end

end

