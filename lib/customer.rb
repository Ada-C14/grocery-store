# Christabel Sebastian
# Ada C14
# Grocery Store: Customer Class
# sources:
## https://stackoverflow.com/questions/336024/calling-a-class-method-within-a-class
## https://stackoverflow.com/questions/4697557/how-to-map-with-index-in-ruby
## per Devin 9/24/2020, for helper methods called in class methods, (1) try and write the helper method as an instance method and see if it works (preferred) (2) otherwise, write it the helper method as a class method (kinda weird) and can put it in a `private` block to indicate/restrict the helper method from being called outside of the class (still kinda weird, but now kinda weird and more clear/restricted) -- see Customer.get_addresses and Order.get_all_products

require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id_num, email, delivery_address_hash)
    @id = id_num
    @email = email
    @address = delivery_address_hash
  end

  def self.all
    external_customer_file = CSV.read('data/customers.csv').map { |row| row.to_a }

    addresses = get_addresses(external_customer_file)

    customers = external_customer_file.each_with_index.map do |customer, i|
      Customer.new(customer[0].to_i, customer[1], addresses[i])
    end

    return customers.sort_by { |customer| customer.id }
  end

  def self.find(id)
    return all.bsearch { |customer| id.to_i <=>  customer.id }
  end

  def self.save(filename, new_customer)
    #mode "a" option = append write-only
    CSV.open(filename, 'a') do |csv|
      new_row = [new_customer.id, new_customer.email, new_customer.address.values].flatten
      csv << new_row
    end
  end

  private

  def self.get_addresses(external_file_data)
    addresses = external_file_data.map do |customer|
      { street: customer[2], city: customer[3], state: customer[4], zip: customer[5] }
    end
    return addresses
  end

end

