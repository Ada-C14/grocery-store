class Customer

  attr_reader :id
  attr_accessor :email, :delivery_address

  def initialize(id, email, delivery_address)
    @id = id
    raise ArgumentError, 'id must be a number.' if id < 1
    @email = email
    raise ArgumentError, 'email must be a string' if email.class != String
    @delivery_address = delivery_address
    raise ArgumentError, 'address must be a hash' if delivery_address.class != Hash
  end
end

# kayla = Customer.new(446456, "kayla@uw.edu", {1 => 2})
# pp kayla
