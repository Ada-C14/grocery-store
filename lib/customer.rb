require 'csv'

class Customer
  attr_reader(:id)
  attr_accessor(:email, :address)

  CUSTOMERS_DATA = CSV.read('../data/customers.csv', headers:true).map { |row| row.to_h }


  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    return CUSTOMERS_DATA
  end

  def self.find(id)
    id = id.to_s
    CUSTOMERS_DATA.each do |customer|
      if customer["customer_id"] == id
      return customer
      end
    end
  end



end