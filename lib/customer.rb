require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize (id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customers = CSV.read('data/customers.csv').map do |row|
      Customer.new(row[0].to_i,row[1],{
          street: row[2],
          city: row[3],
          state: row[4],
          zip: row[5]
      })
    end
    return customers
  end

  def self.find(id)
    return self.all.find{|customer| customer.id == id}
  end
end