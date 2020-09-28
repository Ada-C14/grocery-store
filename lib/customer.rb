require 'csv'

class Customer

  attr_reader :id

  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id # num
    @email = email # string
    @address = address # hash
  end

  def self.all
    customers = CSV.read('data/customers.csv').map do |row|
      Customer.new(row[0].to_i, # id
                   row[1], # email
                   {:street => row[2], # hash address
                    :city => row[3],
                    :state => row[4],
                    :zip => row[5]
                   }
      )
      end
    return customers
  end

  def self.find(id)
    self.all.find { |customer| customer.id == id}
  end

  def Customer.save(filename, new_customer)
    CSV.open(filename, 'a') do |csv| # mode a is append write only.
      csv << [new_customer.id,
              new_customer.email,
              new_customer.address[:street],
              new_customer.address[:city],
              new_customer.address[:state],
              new_customer.address[:zip]
      ]
    end
    return true
  end
end

