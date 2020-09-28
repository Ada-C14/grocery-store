require 'csv'

#require_relative "../data/customers.csv"


class Customer

  def self.all
    headers = [:id, :email, :street, :city, :state, :zip]
    customers = CSV.parse(File.read("./data/customers.csv"), headers: headers).map do |row|
      # address = Hash.new
      # headers.pop(4).each{|header| address[header] = row[header]}
      Customer.new(row[:id].to_i, row[:email], {street: row[:street], city: row[:city], state: row[:state], zip: row[:zip]})
    end
    return customers
  end

  def self.find(id)
    return self.all.find{|customer| customer.id == id}
  end

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id =  id
    @email = email
    @address = address
  end

end