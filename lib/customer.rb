require "csv"


class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id,email,address) #id:number,email:string,address:hash
    @id = id
    @email = email
    @address = address
  end

  def address_hash(array) #wanted it to zip so that if uneven (starting from zipcode up to street address--reversed), it gives remaining element to be address key as array.  For cases like
    labels = [:street, :city, :state, :zip]

    return labels.zip(array).to_h
  end

  def self.all
    all_customers_array = CSV.open("data/customers.csv", "r").map do |customer_info|
      labels = [:street, :city, :state, :zip]
      address = labels.zip(customer_info[2..5]).to_h
      Customer.new(customer_info[0].to_i, customer_info[1], address)
    end

    return all_customers_array
  end

  def self.find(id)
    self.all.each do |search_customer|
      if search_customer.id == id
        return search_customer
      end
    end

    return nil
  end

#WAVE 3
  def self.save(filename, new_customer)

    CSV.open(filename, "w") do |csv|
      csv << [new_customer.id, new_customer.email, new_customer.address]
    end

    return true
  end

end