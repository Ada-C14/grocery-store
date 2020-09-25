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
end

def self.all(file)
  customers = []
  CSV.read(file).each do |record|
    customer = {
        "ID" => record[1],
        "Name" => record[1],
        "Address 1" => record[2],
        "City" => record[3],
        "State" => record[4],
        "Zip Code" => record[5]
    }
    customers << customer
  end
end

pp self.all('../data/customers.csv')

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