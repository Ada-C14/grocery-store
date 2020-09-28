require 'csv'
require_relative '../lib/arg_error'

class Customer
  include ArgError

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    arg_class_check(id, "id", Integer)
    arg_class_check(email, "email", String)
    arg_class_check(address, "address", Hash)

    @id =  id
    @email = email
    @address = address
  end

  def self.all
    headers = [:id, :email, :street, :city, :state, :zip]
    customers = CSV.parse(File.read("./data/customers.csv"), headers: headers).map do |row|
      address = self.row_to_address(headers, row, 2, 5)
      Customer.new(row[:id].to_i, row[:email], address)
    end
    return customers
  end

  def self.find(id)
    self.arg_class_check(id, "id", Integer)
    return self.all.find{|customer| customer.id == id}
  end

  def self.save (filename, new_customer)
    CSV.open(filename, "wb") do |csv|
      csv << [new_customer.id, new_customer.email, new_customer.address[:street], new_customer.address[:city], new_customer.address[:state], new_customer.address[:zip]]
    end
  end

  private
  def self.row_to_address(headers, row,  address_begin, address_end)
    address = Hash.new
    headers[address_begin..address_end].each{|header| address[header] = row[header]}
    return address
  end


end