require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def self.all(filename)
    all_customers = []
    CSV.read(filename, headers: false).each do |record|
      customers = {
          "Customer ID" => record[0],
          "Email" => record[1],
          "Address" => record[2],
          "City" => record[3],
          "State" => record[4],
          "Zip Code" => record[5]
      }
      all_customers << customers
    end
    return all_customers
  end




  # self.find(id)
#   return
#   end
# end


  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end
end


