require "csv"

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    #@info = CSV.read('C:\Users\alice\ADA\grocery-store\data\customers.csv').map{ |row| row.to_a }
    # everything from the csv file is going in here as strings as of right now; each row is a an array
    # an array of arrays (rows) of strings(each column)- separated by commas
    @arr_of_instances = CSV.read('data/customers.csv').map do |row|
      hash_address = {street: row[2], city: row[3], state: row[4], zip: row[5]}
      Customer.new(row[0].to_i, row[1], hash_address)
    end
    return @arr_of_instances
  end


  def self.find(id)
    # 1, leonard.rogahn@hagenes.org, {street: 71596 Eden Route, city: Connellymouth, state: LA, zip: 98872-9105}
    values = Customer.all
    values.each do |instance|
      if instance.id == id
        return instance
      end
    end
    return nil
  end

end