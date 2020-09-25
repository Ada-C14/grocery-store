class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all

  end

end

ID = 123
EMAIL = "a@a.co"
ADDRESS = {
    street: "123 Main",
    city: "Seattle",
    state: "WA",
    zip: "98101"
}

cust = Customer.new(ID, EMAIL, ADDRESS)
p cust