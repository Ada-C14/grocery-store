require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address

  end

  def self.all
    all_customer_instances = []

    CSV.read('data/customers.csv').map { |customer| customer.to_a }.each do |customer|
      id = customer[0].to_i
      email = customer[1]
      address = {
          street: customer[2],
          city: customer[3],
          state: customer[4],
          zip: customer[5]
      }
      all_customer_instances << Customer.new(id, email, address)
    end
    return all_customer_instances
  end

  def self.find(id)

    found_customer = Customer.all.find { |customer| customer.id == id }  #NOTE TO SELF customer.id

    #raise ArgumentError.new("Id not found") if found_customer.nil?

    return found_customer
  end

  def self.save(filename, new_customer)
    #filename: a string, which is a relative path to a new CSV file to create
    # new_customer, an instance of Customer, which is a new customer
    CSV.open("#{filename}", "a") do |csv|
      customer_data = [new_customer.id, new_customer.email, new_customer.address]
      csv << customer_data
    end

    return true
  end

end

#p Customer.all
#
# jared = Customer.new(777, "j@ada.ord", {:street=>"123 Main", :city=>"Seattle", :state=>"WA", :zip=>"98101"})
#
# Customer.save('../data/new_customer_list.csv', jared)


