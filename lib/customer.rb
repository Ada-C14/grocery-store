require "csv"
require "awesome_print"
require "pry"

class Customer
  attr_reader :id, :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

end
