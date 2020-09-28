
class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id #num
    @email = email #string
    @address = address #hash
  end

end