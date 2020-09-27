require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  @@all_customers = nil

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    unless @@all_customers
      @@all_customers = CSV.read("data/customers.csv")
                            .map {|row| Customer.new(row[0].to_i,
                                                     row[1],
                                                     {street: row[2], city: row[3], state: row[4], zip: row[5]})}
    end
    return @@all_customers
  end

  def self.find(id)
    return Customer.all.find {|customer| customer.id == id}
  end

  def self.save(filename, new_customer)
    CSV.open(filename, 'a') do |csv|
      csv << new_customer
    end
    return true
  end
end

