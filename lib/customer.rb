require 'csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id =  id
    @email = email
    @address = address
  end

  def self.all
    headers = [:id, :email, :street, :city, :state, :zip]
    customers = CSV.parse(File.read("./data/customers.csv"), headers: headers).map do |row|
      address = self.headers_to_address(headers, row, 2, 5)
      Customer.new(row[:id].to_i, row[:email], address)
    end
    return customers
  end

  def self.find(id)
    return self.all.find{|customer| customer.id == id}
  end

  private
  def self.headers_to_address(headers, row,  address_begin, address_end)
    address = Hash.new
    headers[address_begin..address_end].each{|header| address[header] = row[header]}
    return address
  end
end