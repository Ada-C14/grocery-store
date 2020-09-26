require 'CSV'

class Customer
  attr_reader :id, :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address

  end

  def self.all # Class method
    customers = CSV.read('data/customers.csv').map do |customer|

    id = customer[0].to_i
    email = customer[1]
    address = {
        street: customer[2],
        city:  customer[3],
        state: customer[4],
        zip: customer[5]
    }
    Customer.new(id, email, address)
    end
  end

  def self.find(wanted_id) # Class method
    customer = (Customer.all).find { |customer| customer.id == wanted_id}
      return customer
  end
end

# emily = Customer.new("12", "emily@gmail.com", "1234 45th ave, Seattle, WA, 98162")
# p emily.address
