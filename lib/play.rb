require 'CSV'
require 'awesome_print'

def products_to_hash(products_string)
  products_hash = Hash.new
  products_string.split(";").each do |string| # line returns [ product1:price1, product2:price2 ]
  product = string.split(":")[0]
  price = string.split(":")[1]
  products_hash[product] = price
  end
  return products_hash
end

ap products_to_hash("name:price;nextname:nextprice")


# def all
#   # customers = CSV.read('data/customers.csv').map { |row| row[1].to_i }
#
#   customers = CSV.read('../data/customers.csv').map { |row|
#     # { row[0].to_i =>
# { "id" => row[0].to_i,
#              "email" => row[1],
#       "address" => {
#           :street => row[2],
#           :city => row[3],
#           :state => row[4],
#           :zip => row[5]
#     }
#     }
#   }
#     return customers
# end
# p all
#
#
# CSV.read('data/customers.csv').each { |customer| @customer.push(new(customer[0].to_i, customer[1], Hash(street: customer[2], city: customer[3], state: customer[4], zip: customer[5]))) }