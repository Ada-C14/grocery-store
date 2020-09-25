require 'csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address

    raise "id must be a number." if id < 1
    raise "email must be a string" if email.class != String
    raise "address must be a hash" if address.class != Hash
  end

  def self.all
    customers = []
    CSV.read('data/customers.csv').map { |row| row.to_a}.each do |row|
      customers << Customer.new(row[0].to_i, row[1], {:street => row[2], :city => row[3], :state => row[4], :zip => row[5]})
    end
    return customers
  end
end


# first = Customer.all.first
# pp first.address[:street]



# pp customers = Customer.all
# pp customers.class

# pp customers = Customer.all


# pp self.all('data/customers.csv')

# def self.find(id)
#
# end



# CSV.read()
# kayla = Customer.new(446456, "kayla@uw.edu", {1 => 2})
# pp kayla
#
#   CSV.read(filename, headers: true).each do |record|
#     medalist = {
#         "ID" => record["ID"],
#         "Name" => record["Name"],
#         "Height" => record["Height"],
#         "Team" => record["Team"],
#         "Year" => record["Year"],
#         "City" => record["City"],
#         "Sport" => record["Sport"],
#         "Event" => record["Event"],
#         "Medal" => record["Medal"]
#     }
#     olympic_medalists << medalist
#   end
#
#   return olympic_medalists