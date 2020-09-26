# frozen_string_literal: true
require 'csv'

class Customer
  attr_reader(:id)
  attr_accessor(:email, :address)

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  # def self.all
  #   return CUSTOMERS_DATA
  # end

  def self.all
    customer_data = CSV.read('data/customers.csv', headers: true).map(&:to_h)
    customers = customer_data.map do |customer|
      Customer.new(customer['customer_id'].to_i, customer['email'], {
            street: customer['address1'],
            city: customer['city'],
            state: customer['state'],
            zip: customer['zip_code']
          })
    end
    customers
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
