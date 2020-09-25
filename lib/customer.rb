

class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address = {street: "", city: "", state: "",zip: ""}  )
    @id = id
    @email = email
    @address = address

  end

end