require 'csv'
# headers = ['id','Email','Address 1', 'City', 'State', 'Zip Code']
# CSV.open('data/customers.csv', 'a+', {force_quotes: true}) do |csv|
#   csv << headers if csv.count.eql? 0
# end

class Customer
  attr_accessor :email, :address
  attr_reader :id

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    all = []

    csv = CSV.read('data/customers.csv').map {|row| row.to_a}
    csv.each do |data|
      customer = []
      customer << @id = data[0].to_i
      customer << @email = "#{data[1]}"
      customer << @address = "#{data[2]}, #{data[3]} #{data[4]}, #{data[5]}"
      all << customer
    end
    return all
  end

  # def self.find(id)
  #
  #
  #
  # end
end

