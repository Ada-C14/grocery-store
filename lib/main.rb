require_relative 'order'
require_relative 'customer'
require 'csv'

# order_something = Order.new(22,{banana: 1, apple: 2}, :complete)
# puts order_something.add_product(:milk,3)
# p order_something.fulfillment_status.class
#order_data = CSV.read('../data/orders.csv', headers:true).map { |row| row.to_h }

# p Customer.all
#p Customer.find(1)
#p Order.all
#
# orders_data = CSV.read('data/orders.csv', headers:true).map { |row| row.to_h }
# p orders_data.last['fulfillment_status']

p Order.all
