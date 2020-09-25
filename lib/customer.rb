require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, delivery_address)
    @id = id
    @email = email
    @address = delivery_address
  end
  
  def self.all
    @customer = Array.new
    CSV.read('data/customers.csv').each { |customer| @customer.push(new(customer[0].to_i, customer[1], Hash(street: customer[2], city: customer[3], state: customer[4], zip: customer[5]))) }
    return @customer
  end

  def self.find(id)
    return all.find { |customer| customer.id == id }
  end
  
  # Optional - save
  def self.save(filename, new_customer)
    @new_customer = new_customer
    a_customer = [@new_customer.id, @new_customer.email, @new_customer.address[:street], @new_customer.address[:city], @new_customer.address[:state], @new_customer.address[:zip]]
    CSV.open(filename, 'w', force_quotes: false) do |csv|
      csv << a_customer
    end
    return true
  end
end