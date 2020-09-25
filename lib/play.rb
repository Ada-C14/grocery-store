require 'money'
def total(products)
  # sum = products.values.inject(0)(:+)
  sum = products.values.inject(0) { |sum, cost| sum + cost }
  tax_rate = 0.075
  unrounded_order_cost = sum + (sum * tax_rate)
  rounded_order_cost = unrounded_order_cost.round(2)
  rounded_order_cost.class
end

  p total({})



