class Customer

  attr_reader :id
  attr_accessor :email_address, :delivery_address

  def initialize(id, email_address, delivery_address)
    @id = id
    @email_address = email_address
    @delivery_address = delivery_address
  end
end