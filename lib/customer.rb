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
    return CSV.read('data/customers.csv').map do |row|
      id = row[0].to_i
      email = row[1]
      street = row[2]
      city = row[3]
      state = row[4]
      zip_code = row[5]
      address = {street: street, city: city, state: state, zip: zip_code}
      Customer.new(id, email, address)
    end
  end

  def self.find(id)
    return self.all.find { |customer| customer.id == id }
  end

end