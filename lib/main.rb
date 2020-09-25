require_relative 'order'
require_relative 'customer'
require 'csv'

# order_something = Order.new(22,{banana: 1, apple: 2}, :complete)
# puts order_something.add_product(:milk,3)
# puts order_something.products
#order_data = CSV.read('../data/orders.csv', headers:true).map { |row| row.to_h }


p Customer.find(35)