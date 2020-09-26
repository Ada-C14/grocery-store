require_relative "customer"

class Order
  attr_reader :id_number

  def initialize(id_number, h_product_price, customer, fulfillment_status = "complete")
    @id_number = id_number
    @h_product_price = h_product_price
    @customer = customer
    @fulfillment_status = fulfillment_status
  end
  def status
    @options = ["pending", "paid", "processing", "shipped", "complete"]
    if @options.include?(@fulfillment_status) == false
      raise ArgumentError
    else
      return @fulfillment_status
    end
  end
  def total
    @total_cost = 0.00
    if @h_product_price == nil
      return @total_cost = 0.0
    else
    @h_product_price.each_value { |value| @total_cost += value }
    @total_cost += (0.075*@total_cost).round(2)
    end
  end

  def add_product(product_name, price)
    @product_name = product_name.to_sym
    @price = price
    puts @product_name
    if @h_product_price.key?(@product_name)
      raise ArgumentError
    else
      @h_product_price.store(@product_name, @price)
    end
  end

end
hash1_address = {:street_number=> "14", :street=> "Park Road", :city=> "London", :zip_code=> "91202"}
customer1 = Customer.new("101020", "oliver.twist@gmail.com", hash1_address )
hash1 = {:butter => 3.50, :flour => 4.00, :milk => 2.00}
hash2 = {}
order1 = Order.new("010203", hash1, customer1, "paid")
total1 = order1.total
puts total1
puts order1.status

order1.add_product("bread", 3.00)