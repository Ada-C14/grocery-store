class Customer
  def initialize (id, email, address)
    @id = id #number
    @email = email #string
    @address = address #hash, will figure out how to deal with this later
  end

  attr_reader :id
  attr_accessor :email, :address

end