
class Customer
  attr_accessor :email, :address
  attr_reader :id

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def summary
    return "Customer #{@id} is at #{@address}. The email is #{@email}"
  end
end

# stacy = Customer.new()
#
# stacy.id