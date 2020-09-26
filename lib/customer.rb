class Customer
  attr_reader :id, :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  # def add_customer(person)
  #   person = (@id, @email, @address)
  #   return person
  # end

  #I'm not sure if this works for address?
  def delivery_address(street, city, state, zip)
    @address = {street: street, city: city, state: state, zip: zip}
    return @address
  end
end


#
# emily = Customer.new("12", "emily@gmail.com", "1234 45th ave, Seattle, WA, 98162")
# p emily.address
