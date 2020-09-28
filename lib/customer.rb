require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def self.all
    all_customers = CSV.read('data/customers.csv').map do |row|
      id = row[0].to_i
      email = row[1]
      address = {:street =>row[2], :city => row[3], :state => row[4], :zip => row[5]}
      Customer.new(row[0].to_i, row[1],address)
    end
    return all_customers
  end


  def self.find(id)
    values = Customer.all
    values.each do |instance|
      if instance.id == id
        return instance
      end
    end
    return nil
  end


  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end
end


