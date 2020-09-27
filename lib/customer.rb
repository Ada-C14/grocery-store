require 'csv'

class Customer
  def initialize (id, email, address)
    @id = id #number
    @email = email #string
    @address = address #hash, will figure out how to deal with this later
  end

  attr_reader :id
  attr_accessor :email, :address

  def self.all
    customers_temp = CSV.read('data/customers.csv').map do |row|
      { "id" => row[0].to_i,
        "email" => row[1],
        "address" => {
            :street => row[2],
            :city => row[3],
            :state => row[4],
            :zip => row[5]
        }
      }
    end

    customers = []
    customers_temp.each do |row|
      customers << Customer.new(row["id"], row["email"], row["address"])
    end

    return customers
  end

  def self.find(id)
    found = Customer.all.select { |customer| customer.id == id }

    return found[0]
  end


end

print Customer.find(3)