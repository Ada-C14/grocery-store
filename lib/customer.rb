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
    Customer.all.find {|customer| customer.id == id}
  end

end

