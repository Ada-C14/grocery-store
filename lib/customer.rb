require 'csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address

    raise "id must be a number." if id < 1
    raise "email must be a string" if email.class != String
    raise "address must be a hash" if address.class != Hash
  end

  def self.all
    customers = []
    CSV.read('data/customers.csv').map { |row| row.to_a}.each do |row|
      customers << Customer.new(row[0].to_i, row[1],
      {:street => row[2], :city => row[3], :state => row[4], :zip => row[5]})
    end
    return customers
  end

  def self.find(id)
    customer_data = Customer.all
    customer_data.each do |customer|
      if customer.id == id
        return  customer
      end
    end
    puts "Sorry, this ID doesn't exist."
  end
end
