require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  # return a collection of Customer instances, representing all of the Customers describe in the CSV file
  def self.all

    # if each is used, need to store the accessed/transformed element somewhere.
    # if map is used, will transform and make NEW array. Just need a variable to store it
    all_customers = CSV.read('data/customers.csv').map do |customer|
      id = customer[0].to_i
      email = customer[1]
      #delivery_address is a hash
      address = {street: customer[2],
                 city: customer[3],
                 state: customer[4],
                 zip: customer[5] }
      Customer.new(id, email, address)
    end
    return all_customers
  end

  # returns matching customer instance as the input
  def self.find(id)
    return all.find {|customer| customer.id == id} # returns nil if ID is not found
  end

  def self.save(filename, new_customer)
    CSV.open(filename, "a") do |csv|
      csv << [new_customer.id,
              new_customer.email,
              new_customer.address[:street],
              new_customer.address[:city],
              new_customer.address[:state],
              new_customer.address[:zip]]
    end
  end

end

#comments : I can improve format and readability. It's better to go vertical than horizontal!
# use more words instead of numbers. .last instead of (length-1)