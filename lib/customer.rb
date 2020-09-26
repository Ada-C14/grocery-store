require 'csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address = {street: "", city: "", state: "",zip: ""}  )
    @id = id
    @email = email
    @address = address

  end

  def self.all
    cust_collection = CSV.read('./data/customers.csv', headers: false).map do |row|
      id = row[0].to_i
      email = row[1]
      street = row[2]
      city = row[3]
      state = row[4]
      zip = row[5]
      Customer.new(id, email, {street: street, city: city, state: state, zip: zip})
    end
    return cust_collection
  end

  def self.find(id)
    return self.all.find {|customer| customer.id == id }
  end

end


