# Pauline Chane (@PaulineChane on GitHub)
# Ada Developers Academy C14
# Grocery Store - customer.rb
# 9/28/2020

# Class object spec file for Customer class.
class Customer
  # generic getters/setters
  attr_accessor :email, :address
  attr_reader :id

  # constructors
  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end
end