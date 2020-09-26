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
    all_customers = []
    CSV.read('data/customers.csv').each do |customer_row|
      id = customer_row[0].to_i
      email = customer_row[1]
      address={}
      address[:street] = customer_row[2]
      address[:city] = customer_row[3]
      address[:state] = customer_row[4]
      address[:zip] = customer_row[5]

      all_customers << Customer.new(id, email, address)
    end
    return all_customers
  end


  def self.find(id)
    all_customers = self.all
    all_customers.each do |customer|
      if customer.id == id
        return customer
      end
    end
    return nil
  end
  #2 variant with enumerable find
  #return all_customers.find{|customer| customer.id == id}
end

