require 'csv'

headers = ['id','email','address']

CSV.open('customers.csv', 'a+', {force_quotes: true}) do |csv|
  csv << headers if csv.count.eql? 0
end


class Customer
  attr_accessor :email, :address
  attr_reader :id

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    return CSV.read('../data/customers.csv', headers: true).map {|row| row.to_a}
  end
  #
  # def self.find(id)
  #
  #
  # end
end

