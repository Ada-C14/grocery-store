require 'csv'
# require 'awesome_print'
class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address

  end

  def self.all
    customer_arr = []
    CSV.read('data/customers.csv').map { |row| row.to_a }.each do |customer|
      customer_arr << Customer.new(customer[0].to_i,customer[1],{street:customer[2], city:customer[3], state:customer[4], zip:customer[5]})
    end
    return customer_arr
  end

  def self.find(id)
    found_customer = Customer.all.find {|customer|id == customer.id}
    puts "Customer not found!" if found_customer == nil
    return found_customer
  end
end

