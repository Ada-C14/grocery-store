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

# kayla = Customer.new(446456, "kayla@uw.edu", {1 => 2})
# pp kayla
