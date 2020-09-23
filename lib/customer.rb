class Customer

  def initialize(id, email, address)
  @id = id
  @email = email
  @address = address
  end

  attr_reader :id, :address
  attr_accessor :name, :email

end
