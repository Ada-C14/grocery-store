require 'csv'
require 'awesome_print'

#CSV.read('planets_data.csv').map { |row| row.to_a } when not using headers

class Customer
  attr_reader :id
  attr_accessor :email, :delivery

  def initialize(id, email, delivery_address)
    @id = id
    @email = email
    @delivery_address = delivery_address
  end
end