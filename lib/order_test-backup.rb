
#
#
# require_relative 'customer'
# # class Order
# #   attr_reader :id
# #   attr_accessor :customer, :products, :fulfillment_status
# #
# #   def initialize(id, products, customer, fulfillment_status = :pending)
# #     @id = id
# #     @products = products
# #     @customer = customer
# #     valid_symbols = [:pending, :paid, :processing, :shipped, :complete]
# #     if !(valid_symbols.include?(fulfillment_status))
# #       raise ArgumentError, "Invalid fulfilment status"
# #     end
# #     @fulfillment_status = fulfillment_status
# #   end
# #
# #   def total(products)
# #     if products.empty?
# #       return 0
# #     end
# #     sum = 0
# #     products.each do |product, cost|
# #       sum += cost
# #     end
# #     tax = sum *  0.075
# #     total_cost = sum + tax
# #     return total_cost.round(2)
# #   end
# #
# #   def add_product(name, price)
# #     @products.each do |product, cost|
# #       if name == product
# #         raise ArgumentError.new("This product is already in our collection.")
# #       else
# #         @products[:product] = name
# #         @products[:cost] = price
# #       end
# #     end
# #     return @products
# #   end
# # end