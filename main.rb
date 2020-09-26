require_relative './lib/Customer'

jared = Customer.new(777, "j@ada.org", {:street=>"123 Main", :city=>"Seattle", :state=>"WA", :zip=>"98101"})
Customer.save('new_customer_list.csv', jared)