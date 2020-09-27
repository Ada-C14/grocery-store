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
      @@all_customers = CSV.read("../data/customers.csv").map {|row| Customer.new(row[0], row[1], "#{row[2]}, #{row[3]}, #{row[4]} #{row[5]}")}
    end
    return @@all_customers
  end

  def self.find(id)
    match = Customer.all.find {|customer| customer.id == id.to_s}
    if match
      return match
    else
      raise ArgumentError, "#{id} is not in the system."
    end
  end

end

p Customer.all
p Customer.find(22)
