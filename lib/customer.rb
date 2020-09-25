require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customer_data = read_customer_csv('data/customers.csv')
    customer_info_array = transform_address(customer_data)
    all_customers = make_customers(customer_info_array)

    return all_customers
  end

  def self.find(id)
    customers_array = all
    return customers_array.find { |customer| customer.id == id }
  end

  def self.save(filename, new_customer)
    CSV.open(filename, "a") do |csv|
      csv << [new_customer.id, new_customer.email, new_customer.address.values].flatten
    end
  end

  def self.read_customer_csv(filename)
    customer_array = CSV.read(filename).map { |row| row.to_a }
    return customer_array
  end

  def self.transform_address(customers_data)
    customers_w_address_hash = []
    customers_data.each do |customer|
      customers_w_address_hash << [
      customer[0].to_i,
      customer[1].to_s,
      {
      street: customer[2].to_s,
      city: customer[3].to_s,
      state: customer[4].to_s,
      zip: customer[5].to_s
      }
      ]
    end
    return customers_w_address_hash
  end

  def self.make_customers(customer_data_array)
    customers_array = customer_data_array.map do |customer|
      Customer.new(customer[0], customer[1], customer[2])
    end
    return customers_array
  end

  private_class_method :make_customers, :transform_address, :read_customer_csv
end
