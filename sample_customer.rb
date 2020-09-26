require 'CSV'
require 'awesome_print'
id = ""
customer = ""
products = ""
# email = ""
# address = ""
fulfillment_status = ""

orders = CSV.read('sample_customer.csv').map do |order|
  id = order[0].to_i
  customer = order[2]
  fulfillment_status = order[3]
  # products = order[1].split{,}
  # item, cost = order[1].split(/\s+/,2)
  # products = {item => cost, item => cost}
  p id
  p customer
  p fulfillment_status
end

#   id = customer[0].to_i
#   email = customer[1]
#   address = {
#         street: customer[2],
#         city:  customer[3],
#         state: customer[4],
#         zip: customer[5]
#   }
#   new_customer = [id, email, address]
# end
# p new_customer
#
# customers.each do |customer|
#   id = customer[0]
#   email = customer[1]
#   address = [street: customer[2], city: customer[3], state: customer[4], zip: customer[5]]
#   customer_array << id
#   customer_array << email
#   customer_array << address
# end
#
# p customer_array
