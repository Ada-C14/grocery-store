class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    raise ArgumentError.new("ID must be a number") unless id.class == Integer
    @id = id
    raise ArgumentError.new("Email must be a string") unless email.class == String
    @email = email
    raise ArgumentError.new("Address must be a hash") unless address.class == Hash
    @address = address
  end
end