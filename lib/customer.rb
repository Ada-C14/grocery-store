class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id_number, email_address, delivery_address)
    @id = id_number
    @email = email_address
    @address = delivery_address
  end

end