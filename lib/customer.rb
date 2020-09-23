# Christabel Sebastian
# Ada C14
# Grocery Store: Customer Class
# sources: https://stackoverflow.com/questions/336024/calling-a-class-method-within-a-class


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

    customers = []
    external_customer_file.each_with_index do |customer, i|
      customers << Customer.new(customer[0].to_i, customer[1], addresses[i])
    end

    return customers
  end

  def self.find(id)
    return all.find { |customer| customer.id == id }
  end

  def self.save(filename, new_customer)
    #mode "a" option = append write-only
    CSV.open(filename, "a") do |csv|
      csv << new_customer.id + ',' + new_customer.email + ',' + new_customer.address.values.join(',')
    end
  end

  private

  def self.get_addresses(two_d_array)
    addresses = two_d_array.map do |customer|
      { street: customer[2], city: customer[3], state: customer[4], zip: customer[5] }
    end
    return addresses
  end

end