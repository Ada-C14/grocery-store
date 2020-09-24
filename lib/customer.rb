require 'csv'

class Customer

  def initialize(id, email, address)
  @id = id
  @email = email
  @address = address
  end

  attr_reader :id
  attr_accessor :email, :address

  def self.all

    customer_array = [] # will become array of customer instances

    CSV.read('data/customers.csv').each do |row_entry| # FIX PATH I keep getting minitest glitch no file errors so i put the file in each folder lol!!!!
      # first, define which entries should be contained in the address
      address = {
          street: row_entry[2],
          city: row_entry[3],
          state: row_entry[4],
          zip: row_entry[5]
      }
      # next, create a new customer instance for each row, adding in the id and email data, along with our newly created address variable
      new_customer = Customer.new(row_entry[0].to_i, row_entry[1], address) # (Q: why can't I call self.new here?)
      # push this to the array
      customer_array << new_customer
    end

    return customer_array

    # return array of instances
    # to be invoked by self.find
  end

  def self.find(id_handed)
    # search thru self.all for instance with id handed, return customer instance

    self.all.find do |customer_instance|
      if customer_instance.id == id_handed
        return customer_instance
      end
    end

    # if id matches customer, return customer
    # not parsing csv, parse arr!
    # return customer
  end
end