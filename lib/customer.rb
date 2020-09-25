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

    csv = CSV.read('data/customers.csv')
    csv.each do |data|
      id = data[0].to_i
      email = data[1]
      address = {
          street: data[2],
          city: data[3],
          state: data[4],
          zip: data[5]
      }
      all << Customer.new(id, email, address)
    end

    return all
  end

  # def self.find(id)
  #
  #
  #
  # end
end

