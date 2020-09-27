require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    raise ArgumentError.new("ID must be a number") unless id.class == Integer
    @id = id
    raise ArgumentError.new("Email must be a string") unless email.class == String
    @email = email
    raise ArgumentError.new("Address must be a hash") unless address.class == Hash
    @address = address
  end

  def self.all
    customers = []
    @path = './data/customers.csv'
    raise LoadError.new("Customer DB not found!") unless File.exist?(@path)
    customer_csv = CSV.read(@path).map { |row| row.to_a }

    customer_csv.each do |customer|
      address = {}
      # Allow for some future extensibility of customer data formatting
      address_fields = [:street, :city, :state, :zip]
      starting_index = 2
      address_fields.each_with_index { |field, i| address[field] = customer[i+starting_index] }
      customers << self.new(customer[0].to_i, customer[1], address)

    end

    return customers
  end

  def self.find(id)
    raise ArgumentError.new("Invalid ID for find()") unless id.class == Integer
    customers = self.all

    # Attempts to speed up lookup times by guessing customer order numbers are sequential
    # Tries once before moving to iteration
    return customers[id-1] if customers[id - 1] != nil && customers[id - 1].id == id

    customers.each do |customer|
      return customer if customer.id == id
    end

    return nil
  end

end