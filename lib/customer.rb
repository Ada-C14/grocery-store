class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, delivery_address)
    @id = id
    @email = email
    @address = delivery_address
  end

end