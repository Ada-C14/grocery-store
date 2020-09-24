class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address

  end

end

# customer = Customer.new(111111, "aba@aba.com", {street_address:"111 Keen Way", city:"seattle", state:"WA", zip:98103})