require_relative 'order'
require_relative 'customer'

# order_something = Order.new(22,{banana: 1, apple: 2}, :complete)
# puts order_something.add_product(:milk,3)
# puts order_something.products
address = {
    street: "123 Main",
    city: "Seattle",
    state: "WA",
    zip: "98101"
}
customer = Customer.new(123, "a@a.co", address)

id = 1337
fulfillment_status = :shipped
order = Order.new(id, {}, customer, fulfillment_status)

puts customer.id
p order

