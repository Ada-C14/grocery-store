require 'csv'
require 'awesome_print'

#CSV.read('planets_data.csv').map { |row| row.to_a } when not using headers

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end
end