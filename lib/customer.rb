require 'csv'

# Create a class called Customer (Wave 1)
class Customer

  # ID should be readable but not writable
  attr_reader :id
  # Email and delivery_address can be both read and written
  attr_accessor :email, :address

  # Define method initialize
  def initialize(id, email, address)
    @id = id # integer
    @email = email
    @address = address
  end
end
