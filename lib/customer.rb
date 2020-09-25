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
    customer_data = CSV.read("data/customers.csv").map do |info|
      self.new(
        info[0].to_i,
        info[1],
        {
          street: info[2],
          city: info[3],
          state: info[4],
          zip: info[5]
        }
      )
    end
    return customer_data
  end

  def self.find(id)
    customer_data = self.all
    search = customer_data.find do |info|
      info if info.id == id
    end
    return search
  end

end