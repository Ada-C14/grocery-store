require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def self.all
    all_customers = CSV.read('data/customers.csv').map do |row|
      id = row[0].to_i
      email = row[1]
      address = {:street =>row[2], :city => row[3], :state => row[4], :zip => row[5]}
      Customer.new(id, email, address)
    end
    return all_customers
  end

  def self.find(id)
    customers = Customer.all
    customers.each do |customer|
        return customer if customer.id == id
      end
    return nil
  end

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end
end


