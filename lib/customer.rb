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
    #customers = []
    #customer_data = nil
    customers = CSV.read('data/customers.csv').map do |info|
      customers_data = Customer.new(info[0].to_i, info[1], {
          :street => info[2],
          :city => info[3],
          :state => info[4],
          :zip => info[5]
      })
    end
    return customers
  end

  #*******
  # def self.all
  #     customers = []
  #     customer_data = nil
  #     CSV.read('data/customers.csv').each do |info|
  #       customer_data = Customer.new(info[0].to_i, info[1], {
  #           :street => info[2],
  #           :city => info[3],
  #           :state => info[4],
  #           :zip => info[5]
  #       })
  #       customers << customer_data
  #     end
  #     return customers
  #   end
  def self.find(id)
     Customer.all.each do |x|
       if id == x.id
         return x
       end
     end
    return nil
  end
end