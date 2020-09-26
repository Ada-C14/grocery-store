class Customer
  attr_reader :id_number
  attr_accessor :email_address, :h_delivery_address

  def initialize(id_number, email_address, h_delivery_address)
    @id_number = id_number
    @email_address = email_address
    @h_delivery_address = h_delivery_address
  end


end