require_relative 'order'
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
    customers = []
    CSV.read('data/customers.csv').map { |row| row.to_a }.each do |customer|
      email = customer[1]
      id = customer[0].to_i
      address = {
          :street => customer[2],
          :city => customer[3],
          :state => customer[4],
          :zip => customer[5]
      }
      customers << Customer.new(id, email, address)
    end
    return customers
  end

  def self.find(id)
    customers = self.all
    customers.each do |customer|
      if customer.id == id
        return customer
      end
    end
    return nil
  end

end



